#lang racket

(require srfi/13)

(define (f test [sep " "] [maxsplit -1])
  (let ([sep (regexp sep)])
    (if (= maxsplit -1)
        (regexp-split sep test)
        (let loop ([result '()]
                   [cnt 0]
                   [strs (regexp-split sep test)])
          (cond
            [(= cnt maxsplit) (append (reverse result) strs)]
            [(null? strs) result]
            [else (loop (cons (car strs) result) (add1 cnt) (cdr strs))])))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ab cd" "x" 2) (list "ab cd") 0.001)
))

(test-humaneval)
