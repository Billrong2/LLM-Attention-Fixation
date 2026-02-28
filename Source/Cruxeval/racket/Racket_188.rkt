#lang racket

(define (f strings)
  (define new-strings '())
  (for ([string (in-list strings)])
    (define first-two (substring string 0 (min 2 (string-length string))))
    (when (or (string-prefix? "a" first-two)
              (string-prefix? "p" first-two))
      (set! new-strings (cons first-two new-strings))))
  (reverse new-strings))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "a" "b" "car" "d")) (list "a") 0.001)
))

(test-humaneval)
