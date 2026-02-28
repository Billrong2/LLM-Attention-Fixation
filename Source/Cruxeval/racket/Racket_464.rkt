#lang racket

(define (f ans)
  (if (andmap char-numeric? (string->list ans))
      (let* ([total (- (* (string->number ans) 4) 50)]
             [not-even-digit? (lambda (c) (not (memq c (list #\0 #\2 #\4 #\6 #\8))))]
             [extra-penalty (* -100 (length (filter not-even-digit? (string->list ans))))])
        (+ total extra-penalty))
      "NAN"))
(require rackunit)

(define (test-f) 

  (let (( candidate f))
    (check-eq? (candidate "example") "NAN")
))

(test-f)
```
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "0") -50 0.001)
))

(test-humaneval)
