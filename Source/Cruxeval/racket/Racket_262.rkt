#lang racket

(define (f nums)
    (define count (length nums))
    (define score (hash 0 "F" 1 "E" 2 "D" 3 "C" 4 "B" 5 "A" 6 ""))
    (define result '())
    (for ([i (in-range count)])
        (set! result (append result (list (hash-ref score (list-ref nums i)))))
    )
    (apply string-append result)
)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 4 5)) "BA" 0.001)
))

(test-humaneval)
