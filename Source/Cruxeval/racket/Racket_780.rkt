#lang racket

(define (f ints)
  (define counts (make-vector 301 0))
  
  (for-each (lambda (i)
              (vector-set! counts i (+ (vector-ref counts i) 1)))
            ints)
  
  (define r (filter (lambda (i) (>= (vector-ref counts i) 3)) (range 301)))
  
  (string-join (map number->string r) " "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 3 5 2 4 5 2 89)) "2" 0.001)
))

(test-humaneval)
