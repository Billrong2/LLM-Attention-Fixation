#lang racket

(define (f text chars)
  (define result (string->list text))
  (let loop ()
    (when (and (> (length result) 2) 
               (sublist? (string->list chars) (take result 3)))
      (set! result (remove-nth result 3))
      (set! result (remove-nth result 3))
      (loop)))
  (list->string result))

(define (remove-nth lst n)
  (append (take lst (- n 1)) (drop lst n)))

(define (sublist? x y)
  (let loop ((x x) (y y))
    (cond ((null? y) #f)
          ((null? x) #t)
          ((equal? (car x) (car y)) (loop (cdr x) (cdr y)))
          (else #f))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ellod!p.nkyp.exa.bi.y.hain" ".n.in.ha.y") "ellod!p.nkyp.exa.bi.y.hain" 0.001)
))

(test-humaneval)
