#lang racket

(define (f perc full)
  (define reply "")
  (define i 0)
  
  (let loop ()
    (cond
      ((and (equal? (string-ref perc i) (string-ref full i))
            (< i (string-length full))
            (< i (string-length perc)))
       (if (equal? (string-ref perc i) (string-ref full i))
           (set! reply (string-append reply "yes "))
           (set! reply (string-append reply "no ")))
       (set! i (+ i 1))
       (loop))
      (else reply))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "xabxfiwoexahxaxbxs" "xbabcabccb") "yes " 0.001)
))

(test-humaneval)
