#lang racket

(define (char-swapcase c)
  (if (char-lower-case? c)
      (char-upcase c)
      (char-downcase c)))

(define (f line)
  (define count 0)
  (define a '())
  (for ([i (in-range (string-length line))])
    (set! count (add1 count))
    (cond
      [(even? count) (set! a (cons (char-swapcase (string-ref line i)) a))]
      [else (set! a (cons (string-ref line i) a))]))
  (apply string (reverse a)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "987yhNSHAshd 93275yrgSgbgSshfbsfB") "987YhnShAShD 93275yRgsgBgssHfBsFB" 0.001)
))

(test-humaneval)
