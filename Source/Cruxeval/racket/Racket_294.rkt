#lang racket

(define (f n m text)
  (if (string=? (string-trim text) "")
      text
      (let* ((head (substring text 0 1))
             (mid (substring text 1 (- (string-length text) 1)))
             (tail (substring text (- (string-length text) 1)))
             (joined (string-append (string-replace head n m)
                                    (string-replace mid n m)
                                    (string-replace tail n m))))
        joined)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "x" "$" "2xz&5H3*1a@#a*1hris") "2$z&5H3*1a@#a*1hris" 0.001)
))

(test-humaneval)
