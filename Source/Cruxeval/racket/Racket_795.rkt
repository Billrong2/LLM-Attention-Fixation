#lang racket

(define (f text)
  (string-replace (string-titlecase text) "Io" "io"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Fu,ux zfujijabji pfu.") "Fu,Ux Zfujijabji Pfu." 0.001)
))

(test-humaneval)
