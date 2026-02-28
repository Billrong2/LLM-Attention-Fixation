#lang racket

(define (f s x)
  (define count 0)
  (let loop ()
    (when (and (>= (string-length s) (string-length x)) 
               (< count (- (string-length s) (string-length x))) 
               (equal? (substring s 0 (string-length x)) x))
      (set! s (substring s (string-length x) (string-length s)))
      (set! count (+ count (string-length x)))
      (loop)))
  s)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "If you want to live a happy life! Daniel" "Daniel") "If you want to live a happy life! Daniel" 0.001)
))

(test-humaneval)
