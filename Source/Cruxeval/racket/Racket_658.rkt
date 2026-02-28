#lang racket

(define (f d get-ary)
    (define result '())
    (for-each (lambda (key) 
                (set! result (append result (list (hash-ref d key #f)))))
              get-ary)
    result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((3 .  "swims like a bull")) (list 3 2 5)) (list "swims like a bull" #f #f) 0.001)
))

(test-humaneval)
