#lang racket

(define (f text)
  (define m 0)
  (define cnt 0)
  (for ([i (in-list (string-split text))])
    (when (> (string-length i) m)
      (set! cnt (+ cnt 1))
      (set! m (string-length i))))
  cnt)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl") 2 0.001)
))

(test-humaneval)
