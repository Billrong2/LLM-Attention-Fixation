#lang racket

(define (f dic key)
  (define v (dict-ref dic key 0))
  (if (= v 0)
      "No such key!"
      (let ([dic-values (dict-values dic)])
        (list-ref dic-values 0))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("did" .  0)) "u") "No such key!" 0.001)
))

(test-humaneval)
