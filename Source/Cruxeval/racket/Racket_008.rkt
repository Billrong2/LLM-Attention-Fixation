#lang racket

(require (only-in file/sha1 sha1-bytes))

(define (rot13 s)
  (define b (for/list ([c (in-string s)])
              (let ([num (char->integer c)])
                (cond
                  [(and (>= num (char->integer #\a)) (<= num (char->integer #\z)))
                   (integer->char (+ (remainder (+ 13 num) 26) (char->integer #\a)))]
                  [(and (>= num (char->integer #\A)) (<= num (char->integer #\Z)))
                   (integer->char (+ (remainder (+ 13 num) 26) (char->integer #\A)))]
                  [else c]))))
  (list->string b))

(define (f string encryption)
  (if (zero? encryption)
      string
      (rot13 (string-upcase string))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "UppEr" 0) "UppEr" 0.001)
))

(test-humaneval)
