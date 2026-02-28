#lang racket

(define (f text old new)
  (if (> (string-length old) 3)
      text
      (if (and (string-contains? text old) (not (string-contains? text " ")))
          (string-replace text old (apply string-append (make-list (string-length old) new)))
          (let loop ((t text))
            (if (string-contains? t old)
                (loop (string-replace t old new))
                t)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "avacado" "va" "-") "a--cado" 0.001)
))

(test-humaneval)
