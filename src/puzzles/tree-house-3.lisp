(defpackage :the-witness.puzzles.tree-house-3
  (:use :common-lisp
        :the-witness.puzzles.solver
        :the-witness.core.point))

(in-package :the-witness.puzzles.tree-house-3)

(defparameter *puzzle*
  (make-array '(9 11) :initial-contents
              '(("." "." "." "." "." "." "." "." "." "." ".")
                ("." "1" "." "1" "." "2" "." "0" "." "0" ".")
                ("." "." "." "." "." "." "." "." "." "." ".")
                ("." "2" "." "2" "." "2" "." "1" "." "3" ".")
                ("." "." "." "." "." "." "." "." "." "." ".")
                ("." "1" "." "1" "." "0" "." "1" "-" "3" ".")
                ("." "." "." "-" "." "." "." "." "." "." ".")
                ("." "3" "." "3" "." "0" "." "0" "." "0" ".")
                ("." "." "." "." "." "." "." "." "." "." "."))))

(defun valid-partition? (points puzzle)
  (let* ((stars-count (count-char "1" points puzzle))
         (green-count (count-char "2" points puzzle))
         (orange-count (count-char "3" points puzzle)))
    (and (or (= 2 stars-count)
             (= 0 stars-count))
         (not (and (> green-count 0) (> orange-count 0))))))

(defun valid-solution? (partitions puzzle)
  (loop for partition-points in partitions do
    (when (not (valid-partition? partition-points puzzle))
      (return-from valid-solution? nil)))
  t)

(defun run ()
  (solve (make-point :x 5 :y 8)
         (make-point :x 5 :y 0)
         #'valid-solution?
         *puzzle*))
