#lang racket

(require srfi/13) 

(define (f text prefix)
    (cond
        [(string-prefix? prefix text) (substring text (string-length prefix) (string-length text))]
        [(string-contains? text prefix) (string-trim-both (string-replace text prefix ""))]
        [else (string-upcase text)]))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abixaaaily" "al") "ABIXAAAILY" 0.001)
))

(test-humaneval)
