#lang racket

(define (f text)
  (define ls (string->list text))
  (for ([x (in-range (sub1 (length ls)) -1 -1)])
    (when (> (length ls) 1)
      (unless (member (list-ref ls x) (string->list "zyxwvutsrqponmlkjihgfedcba"))
        (set! ls (remove (list-ref ls x) ls)))))
  (list->string ls))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "qq") "qq" 0.001)
))

(test-humaneval)
