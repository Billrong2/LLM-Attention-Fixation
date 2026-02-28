#lang racket

(define (f list_ num)
  (define temp '())
  (for ([i list_])
    (set! temp (append temp (list (make-string (* (quotient num 2) (string-length i)) #\,)))))
  temp)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "v") 1) (list "") 0.001)
))

(test-humaneval)
