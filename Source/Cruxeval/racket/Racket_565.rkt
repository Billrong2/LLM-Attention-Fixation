#lang racket

(define (string-index str ch)
  (let loop ((i 0))
    (cond ((= i (string-length str)) -1)
          ((char=? ch (string-ref str i)) i)
          (else (loop (+ i 1))))))

(define (f text)
  (apply max
         (map (lambda (ch) (string-index text ch))
              (string->list "aeiou"))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "qsqgijwmmhbchoj") 13 0.001)
))

(test-humaneval)
