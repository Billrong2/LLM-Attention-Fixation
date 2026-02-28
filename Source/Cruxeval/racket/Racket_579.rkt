#lang racket

(define (f text)
  (cond
    [(string=? text "") text]
    [(and (char-lower-case? (string-ref text 0))
          (char-upper-case? (string-ref text 1)))
     (string-append (string (char-upcase (string-ref text 0)))
                    (substring text 1 (string-length text)))]
    [(string->number text) text]
    [else (string-titlecase text)]))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "") "" 0.001)
))

(test-humaneval)
