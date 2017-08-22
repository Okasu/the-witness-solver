(defpackage :the-witness.puzzles.tree-house-2
  (:use :common-lisp
        :the-witness.puzzles.solver
        :the-witness.core.point))

(in-package :the-witness.puzzles.tree-house-2)

(defparameter *puzzle*
  (make-array '(9 9) :initial-contents
              '(("." "." "." "." "." "." "." "." ".")
                ("." "0" "." "0" "." "0" "." "3" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "1" "." "1" "." "2" "." "0" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "3" "." "0" "." "1" "." "0" ".")
                ("." "." "." "." "." "." "." "." ".")
                ("." "0" "." "3" "." "1" "." "0" ".")
                ("." "." "." "." "." "." "." "." "."))))

(defun count-stars (points puzzle)
  (count-char "1" points puzzle))

(defun count-white (points puzzle)
  (count-char "2" points puzzle))

(defun count-black (points puzzle)
  (count-char "3" points puzzle))

(defun valid-partition? (points puzzle)
  (let* ((stars-count (count-stars points puzzle))
         (white-count (count-white points puzzle))
         (black-count (count-black points puzzle)))
    (and (or (and (= 2 stars-count) (= 0 white-count))
             (and (= 1 stars-count) (= 1 white-count))
             (and (= 2 stars-count) (= 1 black-count))
             (and (= 2 stars-count) (= 2 black-count))
             (= 0 stars-count))
         (not (and (> black-count 0) (> white-count 0))))))

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
