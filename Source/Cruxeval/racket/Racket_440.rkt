#lang racket

(define (f text)
  (if (andmap char-numeric? (string->list text))
      "yes"
      "no"))
(require rackunit)

(define (test-f) 
    (check-equal? (f "example") "no"))

(test-f)
```
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abc") "no" 0.001)
))

(test-humaneval)
