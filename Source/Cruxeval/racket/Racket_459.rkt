#lang racket

(define (f arr d)
  (for ([i (in-range 1 (length arr) 2)])
    (set! d (hash-set d (list-ref arr i) (list-ref arr (- i 1)))))
  d)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "b" "vzjmc" "f" "ae" "0") #hash()) #hash(("vzjmc" .  "b") ("ae" .  "f")) 0.001)
))

(test-humaneval)
