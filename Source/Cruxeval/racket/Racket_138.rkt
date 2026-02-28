#lang racket

(require srfi/13)

(define (f text chars)
  (define listchars (string->list chars))
  (define first (last listchars))
  (for ([i (in-list (drop-right listchars 1))])
    (when (string-contains? text (string i))
      (set! text (string-append (substring text 0 (string-contains-ci text (string i)))
                                (string i)
                                (substring text (+ (string-contains-ci text (string i)) 1))))))
  text)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "tflb omn rtt" "m") "tflb omn rtt" 0.001)
))

(test-humaneval)
