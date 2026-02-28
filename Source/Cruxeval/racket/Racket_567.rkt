#lang racket

(require srfi/1) ;; for drop-right and take-right functions

(define (f s n)
  (let loop ([ls (string-split s)]
             [out '()])
    (if (>= (length ls) n)
        (loop (drop-right ls n) (append out (take-right ls n)))
        (append ls (list (string-join out "_"))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "one two three four five" 3) (list "one" "two" "three_four_five") 0.001)
))

(test-humaneval)
