#lang racket

(require srfi/13)

(define (f address)
  (define suffix-start (add1 (string-index address #\@)))
  (if (> (string-count (substring address suffix-start) #\.) 1)
      (string-trim-right address (string-join (take (string-split (substring address suffix-start) #\.) 2) "."))
      address))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "minimc@minimc.io") "minimc@minimc.io" 0.001)
))

(test-humaneval)
