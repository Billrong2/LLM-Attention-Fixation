#lang racket

(define (f a b c d e)
    (define key d)
    (if (hash-has-key? a key)
        (hash-remove! a key)
        '())
    (if (> b 3)
        (string-append c)
        (hash-ref a key "")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((7 .  "ii5p") (1 .  "o3Jwus") (3 .  "lot9L") (2 .  "04g") (9 .  "Wjf") (8 .  "5b") (0 .  "te6") (5 .  "flLO") (6 .  "jq") (4 .  "vfa0tW")) 4 "Wy" "Wy" 1.0) "Wy" 0.001)
))

(test-humaneval)
