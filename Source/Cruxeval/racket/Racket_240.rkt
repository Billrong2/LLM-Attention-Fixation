#lang racket

(require srfi/13)

(define (f float_number)
  (define number (number->string float_number))
  (define dot (string-index number #\.))
  (if dot
      (let* ([integer-part (substring number 0 dot)]
             [decimal-part (substring number (+ dot 1))]
             [decimal-part-padded (string-append decimal-part (make-string (max 0 (- 2 (string-length decimal-part))) #\0))])
        (string-append integer-part "." decimal-part-padded))
      (string-append number ".00")))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 3.121) "3.121" 0.001)
))

(test-humaneval)
