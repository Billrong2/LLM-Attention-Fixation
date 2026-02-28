#lang racket

(define (f names)
  (define parts (string-split names ","))
  (for/list ([part (in-list parts)]
             [i (in-naturals)])
    (set! parts (list-update parts i (lambda (p) (string-titlecase (string-replace p " and" "+")))))
    (set! parts (list-update parts i (lambda (p) (string-replace p "+" " and")))))
  (string-join parts ", "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "carrot, banana, and strawberry") "Carrot,  Banana,  and Strawberry" 0.001)
))

(test-humaneval)
