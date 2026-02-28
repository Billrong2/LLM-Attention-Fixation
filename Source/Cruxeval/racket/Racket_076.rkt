#lang racket

(define (f nums)
  (let ((nums (filter (lambda (y) (> y 0)) nums)))
    (if (<= (length nums) 3)
        nums
        (let* ((nums (reverse nums))
               (half (quotient (length nums) 2))
               (first-half (take nums half))
               (second-half (drop nums half)))
          (append first-half (build-list 5 (lambda (x) 0)) second-half)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 10 3 2 2 6 0)) (list 6 2 0 0 0 0 0 2 3 10) 0.001)
))

(test-humaneval)
