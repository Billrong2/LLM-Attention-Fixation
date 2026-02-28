#lang racket

(define (f nums)
  (define width (if (null? nums) 0 (string->number (first nums))))
  (for/list ([val (in-list (rest nums))])
    (~a #:min-width width #:pad-string "0" val)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "1" "2" "2" "44" "0" "7" "20257")) (list "2" "2" "44" "0" "7" "20257") 0.001)
))

(test-humaneval)
