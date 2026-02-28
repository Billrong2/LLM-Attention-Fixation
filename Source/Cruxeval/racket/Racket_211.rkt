#lang racket

(define (first-index-of s c)
  (let loop ([i 0])
    (if (>= i (string-length s))
        #f
        (if (char=? (string-ref s i) c)
            i
            (loop (+ i 1))))))

(define (last-index-of s c)
  (let loop ([i (- (string-length s) 1)])
    (if (< i 0)
        #f
        (if (char=? (string-ref s i) c)
            i
            (loop (- i 1))))))

(define (f s)
  (define count 0)
  (for ([c (in-string s)])
    (when (not (= (last-index-of s c) (first-index-of s c)))
      (set! count (+ count 1))))
  count)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abca dea ead") 10 0.001)
))

(test-humaneval)
