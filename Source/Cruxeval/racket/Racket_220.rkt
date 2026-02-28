#lang racket

(define (f text m n)
  (define text-append (string-append text (substring text 0 m) (substring text n)))
  (define result "")
  (for ([i (in-range n (- (string-length text-append) m))])
    (set! result (string-append (substring text-append i (+ i 1)) result)))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abcdefgabc" 1 2) "bagfedcacbagfedc" 0.001)
))

(test-humaneval)
