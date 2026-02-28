#lang racket

(define (f c st ed)
  (define d (make-hash))
  (define a #f)
  (define b #f)
  (for/list ([(x y) c])
    (hash-set! d y x)
    (when (equal? y st) (set! a x))
    (when (equal? y ed) (set! b x)))
  (define w (hash-ref d st))
  (if (string>? a b)
      (list w b)
      (list b w)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("TEXT" .  7) ("CODE" .  3)) 7 3) (list "TEXT" "CODE") 0.001)
))

(test-humaneval)
