#lang racket

(define (f text)
  (define ls (list->string (reverse (string->list text))))
  (define text2 "")
  (for/fold ([i (string-length ls)])
    ([n (in-range (- (string-length ls) 3) 0 -3)])
    (set! text2 (string-append text2 (string-join (map string (string->list (substring ls n (+ n 3)))) "---") "---")))
  (substring text2 0 (- (string-length text2) 3)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "scala") "a---c---s" 0.001)
))

(test-humaneval)
