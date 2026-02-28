#lang racket

(define (f text)
  (with-handlers ([exn:fail? (lambda (e) #f)])
    (string->symbol text)
    #t))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "x") #t 0.001)
))

(test-humaneval)
