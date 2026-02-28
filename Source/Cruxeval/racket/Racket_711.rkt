#lang racket

(define (f text)
    (string-replace text "\n" "\t"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "apples
	
pears
	
bananas") "apples			pears			bananas" 0.001)
))

(test-humaneval)
