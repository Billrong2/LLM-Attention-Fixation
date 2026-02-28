#lang racket

(define (f n s)
  (if (string-prefix? n s)
      (let-values ([(pre _) (string-split s n 1)])
        (string-append pre n (substring s (string-length n))))
      s))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "xqc" "mRcwVqXsRDRb") "mRcwVqXsRDRb" 0.001)
))

(test-humaneval)
