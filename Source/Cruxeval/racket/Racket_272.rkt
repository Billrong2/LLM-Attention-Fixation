#lang racket

(define (f base_list nums)
  (define res (append base_list nums))
  (for ([i (in-range (- (length nums)) 0)])
    (set! res (append res (list (list-ref res (+ (length res) i))))))
  res)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 9 7 5 3 1) (list 2 4 6 8 0)) (list 9 7 5 3 1 2 4 6 8 0 2 6 0 6 6) 0.001)
))

(test-humaneval)
