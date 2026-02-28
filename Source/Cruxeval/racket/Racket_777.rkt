#lang racket

(define (f names excluded)
  (let loop ((names names) (result '()))
    (cond
      [(empty? names) (reverse result)]
      [else (if (string-contains? (car names) excluded)
              (loop (cdr names) (cons (string-replace (car names) excluded "") result))
              (loop (cdr names) (cons (car names) result)))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "avc  a .d e") "") (list "avc  a .d e") 0.001)
))

(test-humaneval)
