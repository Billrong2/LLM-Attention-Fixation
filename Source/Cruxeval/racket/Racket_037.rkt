#lang racket

(define (f text)
  (let loop ((text_arr '())
             (j 0))
    (if (>= j (string-length text))
        text_arr
        (loop (append text_arr (list (substring text j)))
              (+ j 1)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "123") (list "123" "23" "3") 0.001)
))

(test-humaneval)
