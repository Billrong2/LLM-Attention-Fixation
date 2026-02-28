#lang racket

(define (f array num)
  (let* ((reverse? (if (< num 0) #t #f))
         (num (if reverse? (- num) num))
         (array (reverse array))
         (array (apply append (make-list num array)))
         (array (if reverse? (reverse array) array)))
    array))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2) 1) (list 2 1) 0.001)
))

(test-humaneval)
