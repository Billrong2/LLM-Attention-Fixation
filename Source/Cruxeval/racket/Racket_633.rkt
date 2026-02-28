#lang racket

(define (f array elem)
  (let* ((reversed-array (reverse array))
         (found (when (member elem reversed-array) (index-of reversed-array elem))))
    (reverse array)
    found))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 5 -3 3 2) 2) 0 0.001)
))

(test-humaneval)
