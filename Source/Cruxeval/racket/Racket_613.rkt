#lang racket

(define (string-pad-right str len ch)
  (let* ((str-len (string-length str))
         (pad-len (- len str-len)))
    (if (positive? pad-len)
        (string-append str (make-string pad-len ch))
        str)))

(define (f text)
  (define len-text (string-length text))
  (define mid (quotient (- len-text 1) 2))
  (define result '())
  (for ([i (in-range mid)])
    (set! result (cons (string-ref text i) result)))
  (for ([i (in-range mid (sub1 len-text))])
    (set! result (cons (string-ref text (- (+ mid (- len-text 1)) i)) result)))
  (string-pad-right (list->string (reverse result)) len-text (string-ref text (sub1 len-text))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "eat!") "e!t!" 0.001)
))

(test-humaneval)
