#lang racket

(define (f a b c)
  (define result '())
  (for ([d (in-list (list a b c))])
    (set! result (append result (map (lambda (x) (list x #f)) d))))
  (for/fold ([r (hash)])
    ([item result])
    (hash-set r (first item) (second item))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 3) (list 1 4) (list 1 2)) #hash((1 .  #f) (2 .  #f) (3 .  #f) (4 .  #f)) 0.001)
))

(test-humaneval)
