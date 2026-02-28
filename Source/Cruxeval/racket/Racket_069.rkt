#lang racket

(define (f student-marks name)
    (cond
        [(hash-has-key? student-marks name)
            (let ([value (hash-remove! student-marks name)])
                value)]
        [else
            "Name unknown"]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("882afmfp" .  56)) "6f53p") "Name unknown" 0.001)
))

(test-humaneval)
