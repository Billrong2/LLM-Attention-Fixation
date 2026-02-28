#lang racket

(require (only-in srfi/13 string-contains string-reverse))

(define (f text)
  (define result '())
  (for ([i (in-range (string-length text))])
    (let ([ch (string-ref text i)])
      (when (char-upper-case? ch)
        (let ([last-occurrence (string-contains (string-reverse (substring text i)) (string-downcase (string ch)))])
          (when (and last-occurrence (>= last-occurrence i))
            (set! result (cons ch result)))))))
  (apply string (reverse result)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ru") "" 0.001)
))

(test-humaneval)
