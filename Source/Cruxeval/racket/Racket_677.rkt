#lang racket

(define (f text length)
    (let ((length (if (< length 0) (- length) length))
          (output ""))
        (let loop ((idx 0))
            (cond
                ((= idx length) output)
                ((not (char=? (string-ref text (modulo idx (string-length text))) #\space))
                 (set! output (string-append output (string (string-ref text (modulo idx (string-length text))))))
                 (loop (+ idx 1)))
                (else output)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "I got 1 and 0." 5) "I" 0.001)
))

(test-humaneval)
