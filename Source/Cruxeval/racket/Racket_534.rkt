#lang racket

(define (f sequence value)
  (define i (max (- (string-length sequence) (string-length (substring sequence 0 (string-length sequence)))) 0))
  (define result "")
  (for/list ((j (in-range (string-length (substring sequence i (string-length sequence)))))
             (v (in-string (substring sequence i (string-length sequence)))))
    (if (equal? v "+")
        (set! result (string-append result value))
        (set! result (string-append result (substring sequence (+ i j) (+ i j 1))))))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hosu" "o") "hosu" 0.001)
))

(test-humaneval)
