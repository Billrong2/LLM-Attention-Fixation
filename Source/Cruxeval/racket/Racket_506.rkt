#lang racket

(define (f n)
  (define p "")
  (when (= (modulo n 2) 1)
    (set! p (string-append p "sn")))
  (if (not (= (modulo n 2) 1))
      (* n n)
      (for ([x (in-range 1 (+ n 1))])
        (if (= (modulo x 2) 0)
            (set! p (string-append p "to"))
            (set! p (string-append p "ts")))))
  p)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 1) "snts" 0.001)
))

(test-humaneval)
