#lang racket

(define (f num)
  (let loop ([initial '(1)] [total '(1)] [n num])
    (if (zero? n)
        (apply + initial)
        (begin
          (set! total (cons 1 (for/list ([x (in-list total)]
                                        [y (in-list (cdr total))])
                                 (+ x y))))
          (set! initial (append initial (list (last total))))
          (loop initial total (sub1 n))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 3) 4 0.001)
))

(test-humaneval)
