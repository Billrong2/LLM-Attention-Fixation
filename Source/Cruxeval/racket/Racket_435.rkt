#lang racket

(define (f numbers num val)
    (define (insert-at-middle lst item)
        (define middle (quotient (length lst) 2))
        (append (take lst middle) (list item) (drop lst middle)))
    
    (define (insert-multiple lst item n)
        (define middle (quotient (length lst) 2))
        (foldl (lambda (acc _) (insert-at-middle acc item)) lst (range n)))
    
    (let loop ((numbers numbers))
        (cond
            [(< (length numbers) num)
                (loop (insert-at-middle numbers val))]
            [else
                (set! numbers (insert-multiple numbers val (quotient (quotient (length numbers) (sub1 num)) 4)))
                (string-join numbers " ")])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list ) 0 1) "" 0.001)
))

(test-humaneval)
