#lang racket

(define (f text splitter)
    (string-join (string-split (string-downcase text) " ") splitter))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "LlTHH sAfLAPkPhtsWP" "#") "llthh#saflapkphtswp" 0.001)
))

(test-humaneval)
