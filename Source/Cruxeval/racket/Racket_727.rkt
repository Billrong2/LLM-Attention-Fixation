#lang racket

(define (f numbers prefix)
  (sort (map (lambda (n) (if (and (> (string-length n) (string-length prefix)) (string-prefix? prefix n))
                           (substring n (string-length prefix) (string-length n))
                           n))
             numbers)
        string<?))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "ix" "dxh" "snegi" "wiubvu") "") (list "dxh" "ix" "snegi" "wiubvu") 0.001)
))

(test-humaneval)
