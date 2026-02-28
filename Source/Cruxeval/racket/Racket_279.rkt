#lang racket

(define (f text)
  (define ans "")
  (let loop ((text text) (result ans))
    (cond
      [(equal? text "")
       result]
      [else
       (let* ((parts (string-split text "("))
              (x (car parts))
              (sep (if (null? (cdr parts)) "" "("))
              (rest (string-join (cdr parts) "(")))
         (loop rest
               (string-append x sep (string-append "|" result) 
                              (substring rest 0 1) result)))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "") "" 0.001)
))

(test-humaneval)
