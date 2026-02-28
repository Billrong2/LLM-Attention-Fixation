#lang racket

(define (substring-index-right text substr)
  (let loop ([i (sub1 (string-length text))])
    (if (< i 0)
        -1
        (if (string=? (substring text i (string-length text)) substr)
            i
            (loop (sub1 i))))))

(define (f text substr occ)
  (define n 0)
  (let loop ([t text]
             [i 0])
    (define i (substring-index-right t substr))
    (if (equal? i -1)
        -1
        (if (= n occ)
            i
            (loop (substring t 0 i) (add1 n))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "zjegiymjc" "j" 2) -1 0.001)
))

(test-humaneval)
