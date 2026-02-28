#lang racket

(define (f marks)
  (define highest 0)
  (define lowest 100)
  (for ([value (in-list (hash-values marks))])
    (when (> value highest)
      (set! highest value))
    (when (< value lowest)
      (set! lowest value)))
  (list highest lowest))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("x" .  67) ("v" .  89) ("" .  4) ("alij" .  11) ("kgfsd" .  72) ("yafby" .  83))) (list 89 4) 0.001)
))

(test-humaneval)
