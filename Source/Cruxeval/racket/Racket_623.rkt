#lang racket

(define (f text rules)
    (let loop ((text text) (rules rules))
        (cond
            [(null? rules) text]
            [(string=? (car rules) "@") (loop (reverse text) (cdr rules))]
            [(string=? (car rules) "~") (loop (string-upcase text) (cdr rules))]
            [(and (not (string=? text "")) (char=? (string-ref text (- (string-length text) 1)) (string-ref (car rules) 0)))
             (loop (substring text 0 (- (string-length text) 1)) (cdr rules))]
            [else (loop text (cdr rules))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hi~!" (list "~" "`" "!" "&")) "HI~" 0.001)
))

(test-humaneval)
