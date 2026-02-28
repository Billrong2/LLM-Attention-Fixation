#lang racket

(define (f s1 s2)
  (let loop ([k 0])
    (if (>= k (+ (string-length s1) (string-length s2)))
        #f
        (if (string-contains? (string-append s1 (substring s1 0 1)) s2)
            #t
            (loop (add1 k))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Hello" ")") #f 0.001)
))

(test-humaneval)
