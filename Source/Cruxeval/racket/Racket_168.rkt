#lang racket

(define (f text new_value index)
  (define str-list (string->list text))
  (define mapping (list (cons (list-ref str-list index) (string->list new_value))))
  (define new-str-list (map (lambda (c)
                             (if (assoc c mapping)
                                 (cadr (assoc c mapping))
                                 c))
                           str-list))
  (list->string new-str-list))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "spain" "b" 4) "spaib" 0.001)
))

(test-humaneval)
