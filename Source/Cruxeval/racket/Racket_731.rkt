#lang racket

(define (f text use)
    (string-replace text use ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Chris requires a ride to the airport on Friday." "a") "Chris requires  ride to the irport on Fridy." 0.001)
))

(test-humaneval)
