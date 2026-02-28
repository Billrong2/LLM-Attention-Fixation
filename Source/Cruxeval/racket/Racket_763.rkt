#lang racket

(require srfi/13) ;; string operations

(define (f values text markers)
    (string-trim-right text (lambda (c) (or (member c (string->list values)) (member c (string->list markers))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "2Pn" "yCxpg2C2Pny2" "") "yCxpg2C2Pny" 0.001)
))

(test-humaneval)
