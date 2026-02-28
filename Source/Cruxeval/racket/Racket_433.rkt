#lang racket

(define (f text)
  (let* ((text-list (string-split text ","))
         (rest (cdr text-list))
         (t-index (index-of rest "T"))
         (t-value (list-ref rest t-index))
         (rest-without-t (remove "T" rest))
         (final-list (cons t-value rest-without-t)))
    (string-join (cons "T" final-list) ",")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Dmreh,Sspp,T,G ,.tB,Vxk,Cct") "T,T,Sspp,G ,.tB,Vxk,Cct" 0.001)
))

(test-humaneval)
