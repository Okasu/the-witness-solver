(defpackage :the-witness.core.point
  (:use :common-lisp)
  (:export #:make-point
           #:point-x
           #:point-y
           #:point-neighbours))

(in-package :the-witness.core.point)

(defstruct (point (:type list))
  (x 0 :type fixnum)
  (y 0 :type fixnum))

(defun passable? (point puzzle &key filter)
  (destructuring-bind ((x y) (height width)) (list point (array-dimensions puzzle))
    (and (>= x 0) (>= y 0) (< x width) (< y height)
         (if filter
             (equal filter (aref puzzle y x))
             t))))

(defun point-neighbours (point puzzle &key filter)
  (destructuring-bind (x y) point
    (let* ((points (list (list (1+ x) y) (list (1- x) y)
                         (list x (1+ y)) (list x (1- y)))))
      (loop for (x y) in points
            for point = (make-point :x x :y y)
            when (passable? point puzzle :filter filter)
              collect point))))
