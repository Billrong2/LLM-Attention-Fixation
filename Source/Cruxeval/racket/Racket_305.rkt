#lang racket

(define (f text char)
    (define length (string-length text))
    (define index -1)
    (for/list ((i (in-range length)))
        (when (eq? (string-ref text i) char)
            (set! index i)))
    (when (= index -1)
        (set! index (floor (/ length 2))))
    (define new-text (string->list text))
    (set! new-text (remove (list-ref new-text index) new-text))
    (list->string new-text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "o horseto" "r") "o hoseto" 0.001)
))

(test-humaneval)
