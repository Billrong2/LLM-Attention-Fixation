#lang racket

(define (f text char)
  (if (string-contains? text char)
      (let ((text (filter string? (map string-trim (string-split text char)))))
        (> (length text) 1))
      #f))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "only one line" " ") #t 0.001)
))

(test-humaneval)
