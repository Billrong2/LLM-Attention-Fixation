#lang racket

(define (f s)
  (define count (- (string-length s) 1))
  (define reverse_s (list->string (reverse (string->list s))))
  (for ((i count))
    (unless (regexp-match "sea" (substring reverse_s 0 count))
      (set! count (- count 1))
      (set! reverse_s (substring reverse_s 0 count))))
  (substring reverse_s count))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "s a a b s d s a a s a a") "" 0.001)
))

(test-humaneval)
