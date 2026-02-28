#lang racket

(require srfi/13)

(define (f text strip_chars)
  (let* ((rev_text (string-reverse text))
         (trimmed_rev (string-trim-both rev_text (lambda (c) (member c (string->list strip_chars)))))
         (rev_trimmed (string-reverse trimmed_rev)))
    rev_trimmed))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "tcmfsmj" "cfj") "tcmfsm" 0.001)
))

(test-humaneval)
