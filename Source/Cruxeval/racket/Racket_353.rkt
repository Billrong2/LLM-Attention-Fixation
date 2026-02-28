#lang racket

(define (f x)
  (if (equal? x '())
      -1
      (let ((cache (make-hash)))
        (for-each
         (lambda (item)
           (hash-update! cache item (lambda (count) (if count (+ count 1) 1)) 0))
         x)
        (apply max (hash-values cache)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 0 2 2 0 0 0 1)) 4 0.001)
))

(test-humaneval)
