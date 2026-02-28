#lang racket

(define (f s suffix)
  (if (string=? suffix "")
      s
      (let loop ((s s))
        (if (string-suffix? s suffix)
            (loop (substring s 0 (- (string-length s) (string-length suffix))))
            s))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ababa" "ab") "ababa" 0.001)
))

(test-humaneval)
