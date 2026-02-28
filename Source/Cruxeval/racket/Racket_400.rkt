#lang racket

(require srfi/1)

(define (f multi_string)
  (define cond_string (map char-alphabetic? (string->list multi_string)))
  (if (member #t cond_string)
      (string-join (filter (lambda (x) (char-alphabetic? (string-ref x 0))) 
                           (string-split multi_string))
                   ", ")
      ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "I am hungry! eat food.") "I, am, hungry!, eat, food." 0.001)
))

(test-humaneval)
