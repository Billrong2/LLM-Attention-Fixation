#lang racket

(define (f s)
    (string-upcase s))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1") "JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1" 0.001)
))

(test-humaneval)
