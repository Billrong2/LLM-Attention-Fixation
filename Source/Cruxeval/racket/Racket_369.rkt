#lang racket

(define (f var)
  (cond 
    [(string->number var) "int"]
    [(string->number (regexp-replace #px"\\." var "")) "float"]
    [(andmap char-whitespace? (string->list var)) "str"]
    [(= (string-length var) 1) "char"]
    [else "tuple"]))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate " 99 777") "tuple" 0.001)
))

(test-humaneval)
