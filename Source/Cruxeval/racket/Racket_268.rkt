#lang racket

(define (f s separator)
  (let/cc return
    (for ([i (in-range (string-length s))])
      (when (char=? (string-ref s i) (string-ref separator 0))
        (define new-s (string->list s))
        (set! new-s (list-set new-s i #\/))
        (return (string-join (map string new-s) " "))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "h grateful k" " ") "h / g r a t e f u l   k" 0.001)
))

(test-humaneval)
