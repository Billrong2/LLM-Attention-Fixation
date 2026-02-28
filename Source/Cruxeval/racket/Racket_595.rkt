#lang racket

(define (f text prefix)
  (if (string-prefix? prefix text)
      (set! text (substring text (string-length prefix)))
      text)
  (string-titlecase text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "qdhstudentamxupuihbuztn" "jdm") "Qdhstudentamxupuihbuztn" 0.001)
))

(test-humaneval)
