#lang racket

(define (f text)
  (define result "")
  (for ([i (in-range (string-length text))])
    (if (even? i)
        (set! result (string-append result (string (char-upcase (string-ref text i)))))
        (set! result (string-append result (string (string-ref text i))))))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "vsnlygltaw") "VsNlYgLtAw" 0.001)
))

(test-humaneval)
