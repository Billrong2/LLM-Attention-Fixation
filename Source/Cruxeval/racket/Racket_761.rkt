#lang racket

(define (f array)
  (define output (vector->list (list->vector array)))
  (define (swap-evens output)
    (let loop ([i 0] [j (- (length output) 1)])
      (if (and (< i (length output)) (even? i))
          (begin
            (set! output (list-set output i (list-ref output j)))
            (loop (+ i 2) (- j 2)))
          output)))
  (define swapped-output (swap-evens output))
  (reverse swapped-output))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
