#lang racket

(define (string-center str width)
  (let* ((str-len (string-length str))
         (padding (max 0 (- width str-len)))
         (left-padding (quotient padding 2))
         (right-padding (if (even? padding)
                           left-padding
                           (+ left-padding 1))))
    (string-append
     (make-string left-padding #\space)
     str
     (make-string right-padding #\space))))

(define (f text width)
  (define result "")
  (define lines (string-split text "\n"))
  (for ([l (in-list lines)])
    (set! result (string-append result (string-center l width)))
    (set! result (string-append result "\n")))

  ;; Remove the very last empty line
  (set! result (substring result 0 (- (string-length result) 1)))
  result)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "l
l" 2) "l 
l " 0.001)
))

(test-humaneval)
