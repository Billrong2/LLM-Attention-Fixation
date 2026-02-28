#lang racket

(define (f text)
    (cond
        [(string=? text "42.42") #t]
        [else
            (for/or ([i (in-range 3 (- (string-length text) 3))])
                (and (string=? (substring text i (+ i 1)) ".")
                     (string->number (substring text (- i 3) i))
                     (string->number (substring text 0 i))))
                    #t
            #f]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "123E-10") #f 0.001)
))

(test-humaneval)
