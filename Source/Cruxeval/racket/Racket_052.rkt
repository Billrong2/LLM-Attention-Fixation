#lang racket

(define (f text)
  (define a '())
  (for ([i (in-range (string-length text))])
    (unless (char-numeric? (string-ref text i))
      (set! a (append a (list (string-ref text i)))))
    )
  (list->string a)
  )
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "seiq7229 d27") "seiq d" 0.001)
))

(test-humaneval)
