#lang racket

(define (f text)
  (define letters "")
  (for ([i (in-range (string-length text))])
    (if (char-alphabetic? (string-ref text i))
        (set! letters (string-append letters (string (string-ref text i))))
        (when (char-numeric? (string-ref text i))
          (set! letters (string-append letters (string (string-ref text i)))))))
  letters)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "we@32r71g72ug94=(823658*!@324") "we32r71g72ug94823658324" 0.001)
))

(test-humaneval)
