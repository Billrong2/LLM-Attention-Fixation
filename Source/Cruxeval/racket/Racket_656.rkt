#lang racket

(define (f letters)
  (define a '())
  (for ([i (in-naturals)]
        #:break (>= i (length letters)))
    (if (member (list-ref letters i) a)
        "no"
        (set! a (append a (list (list-ref letters i)))))
  )
  "yes"
)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "b" "i" "r" "o" "s" "j" "v" "p")) "yes" 0.001)
))

(test-humaneval)
