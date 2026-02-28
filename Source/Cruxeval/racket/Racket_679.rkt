#lang racket

(define (f text)
    (if (string=? text "")
        #f
        (let* ((first-char (string-ref text 0)))
          (if (char-numeric? first-char)
              #f
              (let loop ((i 0))
                (cond
                  [(>= i (string-length text)) #t]
                  [(and (not (char=? (string-ref text i) #\_))
                        (not (char-alphabetic? (string-ref text i)))) #f]
                  [else (loop (add1 i))]))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "meet") #t 0.001)
))

(test-humaneval)
