(defpackage :the-witness.puzzles.tree-house-4
  (:use :common-lisp
        :the-witness.core.point
        :the-witness.puzzles.solver))

(in-package :the-witness.puzzles.tree-house-4)

(defparameter *puzzle*
  (make-array '(9 9) :initial-contents
              '(("." "." "." "." "." "." "." "." ".")
                ("." "0" "." "1" "." "1" "." "2" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "1" "." "2" "." "0" "." "1" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "1" "." "0" "." "2" "." "1" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "2" "." "1" "." "1" "." "0" ".")
                ("." "." "." "." "." "." "." "." "."))))

(defun valid-partition? (points puzzle)
  (let ((orange-stars (count-char "1" points puzzle))
        (purple-stars (count-char "2" points puzzle)))
    (or (and (= 2 orange-stars)
             (= 0 purple-stars))
        (and (= 2 purple-stars)
             (= 0 orange-stars))
        (and (= 0 orange-stars)
             (= 0 purple-stars))
        (and (= 2 orange-stars)
             (= 2 purple-stars)))))

(defun valid-solution? (partitions puzzle)
  (loop for partition-points in partitions do
    (when (not (valid-partition? partition-points puzzle))
      (return-from valid-solution? nil)))
  t)

(defun run ()
  (solve (make-point :x 4 :y 8)
         (make-point :x 4 :y 0)
         #'valid-solution?
         *puzzle*))
