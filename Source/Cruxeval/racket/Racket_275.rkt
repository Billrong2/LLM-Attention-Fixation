#lang racket

(define (f dic)
  (define dic2 '())
  (set! dic2 (for/hash ([(k v) (in-dict dic)])
                    (values v k)))
  dic2)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((-1 .  "a") (0 .  "b") (1 .  "c"))) #hash(("a" .  -1) ("b" .  0) ("c" .  1)) 0.001)
))

(test-humaneval)
