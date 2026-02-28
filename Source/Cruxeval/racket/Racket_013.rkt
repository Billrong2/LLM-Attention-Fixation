#lang racket

(require racket/string)

(define (f names)
  (let ([count (length names)]
        [numberOfNames 0])
    (for ([i names])
      (when (andmap char-alphabetic? (string->list i))
        (set! numberOfNames (+ numberOfNames 1))))
    numberOfNames))

(require rackunit)

(define (check candidate) 
  (check-eqv? (candidate '("a" "b" "c")) 3))

(check f)
```
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "sharron" "Savannah" "Mike Cherokee")) 2 0.001)
))

(test-humaneval)
