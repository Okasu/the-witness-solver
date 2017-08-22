(defpackage :the-witness.util.partition
  (:use :common-lisp
        :the-witness.core.point)
  (:export #:partitions))

(in-package :the-witness.util.partition)

(defun next-moves (point visited puzzle)
  (loop for point in (point-neighbours point puzzle :filter "x")
        when (not (member point visited :test #'equalp)) collect point))

(defun near-wall? (point puzzle)
  (destructuring-bind ((x y) (height width)) (list point (array-dimensions puzzle))
    (or (= x 0)
        (= y 0)
        (= y (1- height))
        (= x (1- width)))))

(defun hit-wall? (point puzzle)
  (and (near-wall? point puzzle)
       (find-if #'(lambda (x) (not (near-wall? x puzzle)))
                (next-moves point (list point) puzzle))))

(defun %wall-hit-locations (start visited result puzzle)
  (let* ((visited (cons start visited))
         (next-move (first (next-moves start visited puzzle))))
    (if (null next-move)
        result
        (if (hit-wall? next-move puzzle)
            (%wall-hit-locations next-move visited (cons next-move result) puzzle)
            (%wall-hit-locations next-move visited result puzzle)))))

(defun wall-hit-locations (start puzzle)
  (%wall-hit-locations start '() '() puzzle))

(defun partition-entry-points (wall-hit-point puzzle)
  (destructuring-bind ((x y) (height width)) (list wall-hit-point (array-dimensions puzzle))
    (cond ((or (= x 0) (= x (1- width)))
           (list (make-point :x x :y (1+ y))
                 (make-point :x x :y (1- y))))
          ((or (= y 0) (= y (1- height)))
           (list (make-point :x (1+ x) :y y)
                 (make-point :x (1- x) :y y))))))

(defun neighbours (point puzzle)
  (loop for point in (point-neighbours point puzzle)
        for (x y) = point
        when (not (equal "x" (aref puzzle y x))) collect point))

(defun %partition-points (visited queue puzzle)
  (when (null queue) (return-from %partition-points visited))
  (loop for point in (neighbours (pop queue) puzzle)
        when (not (member point visited :test #'equalp)) do
          (push point queue)
          (push point visited))
  (%partition-points visited queue puzzle))

(defun partition-points (start puzzle)
  (%partition-points (list start) (list start) puzzle))

(defun partitions (start puzzle)
  (let ((wall-hit-points (wall-hit-locations start puzzle)))
    (if (null wall-hit-points)
        (list (partition-points (make-point :x 1 :y 1) puzzle))
        (loop for wall-hit-point in wall-hit-points
              for entry-points = (partition-entry-points wall-hit-point puzzle) append
          (loop for entry-point in entry-points collect
            (partition-points entry-point puzzle))))))
