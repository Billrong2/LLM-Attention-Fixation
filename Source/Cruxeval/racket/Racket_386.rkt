#lang racket

(define (f concat di)
  (define count (hash-count di))
  (for ([i (in-range count)])
    (when (member (hash-ref di (number->string i)) (string->list concat))
      (hash-remove! di (number->string i))))
  "Done!")
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mid" #hash(("0" .  "q") ("1" .  "f") ("2" .  "w") ("3" .  "i"))) "Done!" 0.001)
))

(test-humaneval)
