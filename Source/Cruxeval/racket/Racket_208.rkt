#lang racket

(define (f items)
  (define result '())
  (for* ([item (in-list items)]
         [d (in-string item)])
    (unless (char-numeric? d)
      (set! result (append result (list (string d))))))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "123" "cat" "d dee")) (list "c" "a" "t" "d" " " "d" "e" "e") 0.001)
))

(test-humaneval)
