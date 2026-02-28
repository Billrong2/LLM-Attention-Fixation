#lang racket

(define (f s)
  (define nums (list->string (filter (lambda (c) (char-numeric? c)) (string->list s))))
  (if (string=? nums "")
      "none"
      (let ((numbers (map string->number (string-split nums ","))))
        (number->string (apply max numbers)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "01,001") "1001" 0.001)
))

(test-humaneval)
