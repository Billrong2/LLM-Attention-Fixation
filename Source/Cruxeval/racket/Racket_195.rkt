#lang racket

(define (remove-prefix str prefix)
  (if (string-prefix? prefix str)
      (substring str (string-length prefix))
      str))

(define (f text)
  (for ([p (in-list '("acs" "asp" "scn"))])
    (set! text (string-append (remove-prefix text p) " ")))
  (substring (remove-prefix text " ") 0 (- (string-length text) 1)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ilfdoirwirmtoibsac") "ilfdoirwirmtoibsac  " 0.001)
))

(test-humaneval)
