#lang racket

(define (f n array)
    (define final (list (copy-list array)))
    (let loop ((i 0) (final final))
        (if (= i n)
            final
            (loop (+ i 1) (append final (list (append (copy-list array) (last final))))))))

(define (copy-list lst)
    (map values lst))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 1 (list 1 2 3)) (list (list 1 2 3) (list 1 2 3 1 2 3)) 0.001)
))

(test-humaneval)
