#lang racket

(define (f nums target)
  (define count 0)
  (for-each
   (lambda (n1)
     (for-each
      (lambda (n2)
        (set! count (+ count (if (= (+ n1 n2) target) 1 0))))
      nums))
   nums)
  count)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3) 4) 3 0.001)
))

(test-humaneval)
