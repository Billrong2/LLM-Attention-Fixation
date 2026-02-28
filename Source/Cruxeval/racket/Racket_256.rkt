#lang racket

(define (rfind text sub)
  (let loop ((i (- (string-length text) 1)))
    (cond
      [(< i 0) -1]
      [(string=? (substring text i (+ i (string-length sub))) sub) i]
      [else (loop (- i 1))])))

(define (f text sub)
  (define a 0)
  (define b (- (string-length text) 1))
  (define loop
    (lambda ()
      (define c (quotient (+ a b) 2))
      (cond
        [(>= (rfind text sub) c)
         (begin
           (set! a (+ c 1))
           (loop))]
        [else
         (begin
           (set! b (- c 1))
           (if (< a b)
               (loop)
               a))])))
  (loop))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "dorfunctions" "2") 0 0.001)
))

(test-humaneval)
