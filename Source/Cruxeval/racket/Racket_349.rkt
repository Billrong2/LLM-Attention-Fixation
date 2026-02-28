#lang racket

(define (f dictionary)
  (define new-dict (hash-set dictionary "1049" 55))
  (define key-value (hash-ref new-dict (car (hash-keys new-dict))))
  (hash-set new-dict (car (hash-keys new-dict)) key-value))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("noeohqhk" .  623))) #hash(("noeohqhk" .  623) ("1049" .  55)) 0.001)
))

(test-humaneval)
