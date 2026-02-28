#lang racket

(require srfi/13) ;; for string-downcase and string-upcase

(define (f text)
  (if (string=? text (string-upcase text))
      (string-downcase text)
      (string-take (string-downcase text) 3)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n") "mty" 0.001)
))

(test-humaneval)
