#lang racket

(define (f array)
  (define d (make-immutable-hash (map cons (map car array) (map cadr array))))
  (for/fold ([result #hash()])
            ([(k v) (in-hash d)])
    (if (or (< v 0) (> v 9)) 
        (error "Value out of range")
        (hash-set result k v))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list 8 5) (list 8 2) (list 5 3))) #hash((8 .  2) (5 .  3)) 0.001)
))

(test-humaneval)
