#lang racket

(define (f text chars)
  (define chars-list (string->list chars))
  (define text-list (string->list text))
  (define new_text text-list)
  
  (define (helper text new-text chars)
    (cond
      [(and (> (length new-text) 0) text)
       (if (member (car new-text) chars)
           (helper (cdr text) (cdr new-text) chars)
           (list->string new-text))]
      [else
       (list->string new-text)]))
  
  (helper text-list new_text chars-list))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "asfdellos" "Ta") "sfdellos" 0.001)
))

(test-humaneval)
