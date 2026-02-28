#lang racket

(define (f nums)
  (let loop ((i (- (length nums) 1)))
    (cond
      ((< i 0) nums)
      ((= (list-ref nums i) 0) (list) #f)
      (else (loop (- i 3))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 0 1 2 1)) #f 0.001)
))

(test-humaneval)
