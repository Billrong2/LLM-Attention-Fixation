#lang racket

(define (f text repl)
  (define trans (make-hash))
  (for ([i (in-range (min (string-length text) (string-length repl)))])
    (hash-set! trans (string-ref (string-downcase text) i) (string-ref (string-downcase repl) i)))
  (list->string (map (lambda (c) (hash-ref trans c c)) (string->list (string-downcase text)))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "upper case" "lower case") "lwwer case" 0.001)
))

(test-humaneval)
