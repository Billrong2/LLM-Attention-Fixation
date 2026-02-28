#lang racket

(define (f d)
    (define keys '())
    (for ([k (in-dict-keys d)])
        (set! keys (append keys (list (format "~a => ~a" k (hash-ref d k))))))
    keys)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("-4" .  "4") ("1" .  "2") ("-" .  "-3"))) (list "-4 => 4" "1 => 2" "- => -3") 0.001)
))

(test-humaneval)
