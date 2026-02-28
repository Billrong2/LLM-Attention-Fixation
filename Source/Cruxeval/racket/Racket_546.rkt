#lang racket

(define (f text speaker)
  (define length-speaker (string-length speaker))
  (if (and (>= (string-length text) length-speaker) 
           (string=? speaker (substring text 0 length-speaker)))
      (f (substring text length-speaker) speaker)
      text))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "[CHARRUNNERS]Do you know who the other was? [NEGMENDS]" "[CHARRUNNERS]") "Do you know who the other was? [NEGMENDS]" 0.001)
))

(test-humaneval)
