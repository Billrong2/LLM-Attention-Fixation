#lang racket

(define (f L m start step)
  (define (insert-m L start)
    (if (= start 0)
        (cons m L)
        (cons (first L) (insert-m (rest L) (- start 1)))))
  (define (pop-m L start m)
    (if (empty? L)
        '()
        (cons (first L)
              (if (and (not (= start 0)) (equal? (first L) m))
                  (pop-m (rest L) (- start 1) m)
                  (pop-m (rest L) start m)))))
  (insert-m (pop-m L start m) start))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 7 9) 3 3 2) (list 1 2 7 3 9) 0.001)
))

(test-humaneval)
