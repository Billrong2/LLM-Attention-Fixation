#lang racket

(define (f stg tabs)
    (define (remove-tabs str tab)
        (regexp-replace* (regexp (string-append tab "$")) str ""))
    
    (for/fold ((result stg))
              ((tab tabs))
        (remove-tabs result tab)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "31849 let it!31849 pass!" (list "3" "1" "8" " " "1" "9" "2" "d")) "31849 let it!31849 pass!" 0.001)
))

(test-humaneval)
