#lang racket

(require srfi/13 ; string library
         srfi/14 ; character-set library
         )

(define (f string sep) 
  (let* ((count (string-count string (lambda (c) (char=? c (string-ref sep 0)))))
         (new-string (string-append string sep)))
    (list->string (reverse (string->list (string-append new-string new-string))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "caabcfcabfc" "ab") "bacfbacfcbaacbacfbacfcbaac" 0.001)
))

(test-humaneval)
