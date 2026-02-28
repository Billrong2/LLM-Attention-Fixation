#lang racket

(define (f text)
  (define text-list (string->list text))
  (for ([i (in-naturals)] [char (in-list text-list)])
    (set! text-list (list-set text-list i 
                             (if (char-lower-case? char) 
                                 (char-upcase char) 
                                 (char-downcase char)))))
  (list->string text-list))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "akA?riu") "AKa?RIU" 0.001)
))

(test-humaneval)
