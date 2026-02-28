#lang racket

(define (f text)
  (let ([out ""])
    (for ([i (in-range (string-length text))])
      (if (char-upper-case? (string-ref text i))
          (set! out (string-append out (string (char-downcase (string-ref text i)))))
          (set! out (string-append out (string (char-upcase (string-ref text i)))))))
    out))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate ",wPzPppdl/") ",WpZpPPDL/" 0.001)
))

(test-humaneval)
