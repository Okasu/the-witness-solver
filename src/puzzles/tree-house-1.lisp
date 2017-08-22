(defpackage :the-witness.puzzles.tree-house-1
  (:use :common-lisp
        :the-witness.core.point
        :the-witness.puzzles.solver))

(in-package :the-witness.puzzles.tree-house-1)

(defparameter *puzzle*
  (make-array '(9 9) :initial-contents
              '(("." "." "." "." "." "." "." "." ".")
                ("." "1" "." "0" "." "0" "." "1" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "1" "." "0" "." "0" "." "1" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "1" "." "1" "." "0" "." "1" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "0" "." "0" "." "0" "." "1" ".")
                ("." "." "." "." "." "." "." "." "."))))

(defun valid-partition? (points puzzle)
  (let ((stars-count (count-char "1" points puzzle)))
    (or (= 2 stars-count)
        (= 0 stars-count))))

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
