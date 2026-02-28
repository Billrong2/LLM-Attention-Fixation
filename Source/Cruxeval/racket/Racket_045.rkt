#lang racket

(require racket/string)

(define (f text letter)
  (define counts (make-hash))
  (for ([char (in-string text)])
    (hash-update! counts char (lambda (x) (+ x 1)) 0))
  (hash-ref counts (if (string? letter) (string-ref letter 0) letter) 0))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "za1fd1as8f7afasdfam97adfa" "7") 2 0.001)
))

(test-humaneval)
