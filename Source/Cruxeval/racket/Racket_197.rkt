#lang racket

(define (f temp timeLimit)
  (let* ([s (quotient timeLimit temp)]
         [e (remainder timeLimit temp)]
         [result1 (format "~a oC" e)]
         [result2 (format "~a ~a" s e)])
    (if (> s 1)
        result2
        result1)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 1 1234567890) "1234567890 0" 0.001)
))

(test-humaneval)
