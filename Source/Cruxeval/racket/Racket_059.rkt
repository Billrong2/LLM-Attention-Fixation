#lang racket

(define (f s)
  (define a (filter (λ (char) (not (char=? char #\space))) (string->list s)))
  (define b a)
  (for ([c (in-list (reverse a))])
    (when (char=? c #\space)
      (set! b (remove c b))))
  (list->string b))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hi ") "hi" 0.001)
))

(test-humaneval)
