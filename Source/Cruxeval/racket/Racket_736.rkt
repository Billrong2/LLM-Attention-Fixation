#lang racket

(define (f text insert)
  (define whitespaces (string->list "\\t\\r\\v \\f\\n"))
  (define clean "")
  (for ([char (in-string text)])
    (if (member char whitespaces)
        (set! clean (string-append clean insert))
        (set! clean (string-append clean (string char)))))
  clean)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "pi wa" "chi") "pichiwa" 0.001)
))

(test-humaneval)
