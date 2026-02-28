#lang racket

(define (f parts)
  (map cdr (dict->list (apply hash (apply append parts)))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list "u" 1) (list "s" 7) (list "u" -5))) (list -5 7) 0.001)
))

(test-humaneval)
