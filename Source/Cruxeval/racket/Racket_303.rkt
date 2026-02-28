#lang racket

(define (f text)
  (let ([i (quotient (+ (string-length text) 1) 2)])
    (let loop ([i i]
               [result (string->list text)])
      (cond
        [(>= i (length result)) (list->string result)]
        [else
         (let ([t (char-downcase (list-ref result i))])
           (cond
             [(eq? t (list-ref result i)) (loop (+ i 1) result)]
             [else (loop (+ i 2) (list-set result i t))]))]))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mJkLbn") "mJklbn" 0.001)
))

(test-humaneval)
