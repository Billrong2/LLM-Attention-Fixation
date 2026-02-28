#lang racket

(define (f array elem)
    (let loop ((idx 0)
               (arr array))
        (cond
            ((>= idx (length arr))
                arr)
            ((and (> (list-ref arr idx) elem)
                  (< (list-ref arr (- idx 1)) elem))
                (loop (+ idx 1) (append (take arr idx) (list elem) (drop arr idx))))
            (else
                (loop (+ idx 1) arr)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 5 8) 6) (list 1 2 3 5 6 8) 0.001)
))

(test-humaneval)
