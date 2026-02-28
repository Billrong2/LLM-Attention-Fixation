#lang racket

(define (f w)
    (define ls (string->list w))
    (define omw "")
    (let loop ((ls ls) (omw omw))
        (cond
            [(> (length ls) 0)
                (set! omw (string-append omw (list->string (list (car ls)))))
                (if (> (* 2 (length ls)) (string-length w))
                    (equal? (substring w (length ls)) omw)
                    (loop (cdr ls) omw))]
            [else #f])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "flak") #f 0.001)
))

(test-humaneval)
