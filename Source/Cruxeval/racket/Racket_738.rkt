#lang racket

(define (string-trim-right str char)
  (let loop ([i (sub1 (string-length str))])
    (if (and (>= i 0)
             (char=? (string-ref str i) char))
        (loop (sub1 i))
        (substring str 0 (add1 i)))))

(define (f text characters)
  (for ([i (in-range (string-length characters))])
    (let ([char (substring characters i (add1 i))])
      (set! text (string-trim-right text (string-ref char 0)))))
  text)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "r;r;r;r;r;r;r;r;r" "x.r") "r;r;r;r;r;r;r;r;" 0.001)
))

(test-humaneval)
