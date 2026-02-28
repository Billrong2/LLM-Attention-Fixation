#lang racket

(require srfi/13)

(define (f forest animal)
  (define index (string-index forest (string-ref animal 0)))
  (define result (string->list forest))
  (define len (string-length forest))
  (let loop ([index index])
    (if (< index (- len 1))
        (begin
          (set! result (list-set result index (list-ref result (+ index 1))))
          (loop (+ index 1)))
        (when (= index (- len 1))
          (set! result (list-set result index #\-)))))
  (list->string result))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "2imo 12 tfiqr." "m") "2io 12 tfiqr.-" 0.001)
))

(test-humaneval)
