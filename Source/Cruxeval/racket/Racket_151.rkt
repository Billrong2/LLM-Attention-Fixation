#lang racket

(define (f text)
  (define (replace-char c)
    (if (equal? c #\0)
        #\.
        (if (equal? c #\1)
            #\0
            c)))
  
  (define (process-char c)
    (if (char-numeric? c)
        (replace-char c)
        c))
  
  (define (process-text text)
    (list->string (map process-char (string->list text))))
  
  (define replaced-text (process-text text))
  (string-replace replaced-text "." "0"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "697 this is the ultimate 7 address to attack") "697 this is the ultimate 7 address to attack" 0.001)
))

(test-humaneval)
