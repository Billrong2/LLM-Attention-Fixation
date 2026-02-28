#lang racket

(define (f string)
    (define l (string->list string))
    (let loop ((i (- (length l) 1)))
        (cond
            [(< i 0) (list->string l)]
            [(not (char=? (list-ref l i) #\space)) (list->string l)]
            [else
             (set! l (remove i l))
             (loop (- i 1))])))

(define (remove index lst)
    (append (take lst index) (drop lst (+ index 1))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "    jcmfxv     ") "    jcmfxv" 0.001)
))

(test-humaneval)
