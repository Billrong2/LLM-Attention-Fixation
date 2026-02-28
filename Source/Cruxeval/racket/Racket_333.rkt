#lang racket

(define (f places lazy)
  (define sorted-places (sort places <))
  (for-each (lambda (l) (set! sorted-places (remove l sorted-places))) lazy)
  (define i 0)
  (if (= (length sorted-places) 1)
      1
      (let loop ((index 0))
        (define place (list-ref sorted-places index))
        (if (= (count (lambda (x) (= x (+ place 1))) sorted-places) 0)
            (+ index 1)
            (loop (+ index 1))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 375 564 857 90 728 92) (list 728)) 1 0.001)
))

(test-humaneval)
