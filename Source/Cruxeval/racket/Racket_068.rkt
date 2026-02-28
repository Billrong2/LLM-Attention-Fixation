#lang racket

(define (f text pref)
  (if (string-prefix? text pref)
      (let* ((n (string-length pref))
             (start (substring text n (string-length text)))
             (end (substring text 0 (- n 1)))
             (start-parts (cdr (string-split start ".")))
             (end-parts (take (string-split end ".") (- (length (string-split end ".")) 1))))
        (string-join (append start-parts end-parts) "."))
      text))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "omeunhwpvr.dq" "omeunh") "dq" 0.001)
))

(test-humaneval)
