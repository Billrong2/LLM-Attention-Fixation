#lang racket

(define (f text char min_count)
  (let ((count (length (regexp-match* char text))))
    (if (< count min_count)
        (string-upcase text)
        text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "wwwwhhhtttpp" "w" 3) "wwwwhhhtttpp" 0.001)
))

(test-humaneval)
