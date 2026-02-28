#lang racket

(define (f text tab-size)
  (define res "")
  (set! text (string-replace text "\t" (make-string (- tab-size 1) #\space)))
  (for ([i (in-range (string-length text))])
    (if (char=? (string-ref text i) #\space)
        (set! res (string-append res "|"))
        (set! res (string-append res (string (string-ref text i))))))
  res)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "	a" 3) "||a" 0.001)
))

(test-humaneval)
