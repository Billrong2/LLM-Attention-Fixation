#lang racket

(define (f string)
  (if (or (string=? string "")
          (not (char-numeric? (string-ref string 0))))
      'INVALID
      (let loop ((cur 0)
                 (i 0))
        (if (= i (string-length string))
            (number->string cur)
            (loop (+ (* cur 10)
                     (string->number (substring string i (+ i 1))))
                  (+ i 1))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "3") "3" 0.001)
))

(test-humaneval)
