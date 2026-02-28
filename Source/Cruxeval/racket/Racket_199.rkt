#lang racket

;; Custom function to count occurrences of a character in a string
(define (count-char s char)
  (for/sum ([c (in-string s)])
    (if (char=? c (string-ref char 0)) 1 0)))

(define (f s char)
  (define base (make-string (+ (count-char s char) 1) (string-ref char 0)))
  (if (string-suffix? s base)
      (substring s 0 (- (string-length s) (string-length base)))
      s))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mnmnj krupa...##!@#!@#$$@##" "@") "mnmnj krupa...##!@#!@#$$@##" 0.001)
))

(test-humaneval)
