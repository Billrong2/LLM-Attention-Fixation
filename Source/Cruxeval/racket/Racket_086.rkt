#lang racket

(define (f instagram imgur wins)
  (define photos (list instagram imgur))
  (cond 
    [(equal? instagram imgur) wins]
    [(= wins 1) (last photos)]
    [else 
      (set! photos (reverse photos))
      (last photos)]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "sdfs" "drcr" "2e") (list "sdfs" "dr2c" "QWERTY") 0) (list "sdfs" "drcr" "2e") 0.001)
))

(test-humaneval)
