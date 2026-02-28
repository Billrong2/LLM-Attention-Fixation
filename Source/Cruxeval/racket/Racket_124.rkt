#lang racket

(require srfi/13) ; for string utilities

(define (f txt sep sep_count)
  (define o "")
  (let loop ((txt txt) (sep_count sep_count))
    (if (or (<= sep_count 0) (zero? (string-count txt sep)))
        (string-append o txt)
        (begin
          (set! o (string-append o (string-reverse (string-split (string-reverse txt) sep #f 2) sep 0)))
          (set! txt (cadr (string-split (string-reverse txt) sep #f 2)))
          (loop txt (- sep_count 1)))))
  )

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "i like you" " " -1) "i like you" 0.001)
))

(test-humaneval)
