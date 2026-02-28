#lang racket

(define (f text suffix)
  (if (and (not (string=? suffix ""))
           (string-contains? text (string (string-ref suffix (- (string-length suffix) 1)))))
      (f (regexp-replace* (regexp (string-append (regexp-quote (string (string-ref suffix (- (string-length suffix) 1)))) "$")) text "")
         (substring suffix 0 (- (string-length suffix) 1)))
      text))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "rpyttc" "cyt") "rpytt" 0.001)
))

(test-humaneval)
