#lang racket

(define (f text)
  (define valid-chars '("-" "_" "+" "." "/" " "))
  (set! text (string-upcase text))
  (let loop ((chars (string->list text)))
    (cond
      ((null? chars) #t)
      ((and (not (char-alphabetic? (car chars)))
            (not (member (car chars) valid-chars)))
       #f)
      (else (loop (cdr chars)))))
  )
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW") #f 0.001)
))

(test-humaneval)
