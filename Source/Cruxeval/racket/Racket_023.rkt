#lang racket

(require srfi/13) ;; For string-trim-right

(define (f text chars)
  (define trimmed-text 
    (if (zero? (string-length chars))
        (string-trim-right text)
        (string-trim-right text (lambda (c) (string-contains chars (string c))))))
  (if (equal? trimmed-text "")
      "-"
      trimmed-text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "new-medium-performing-application - XQuery 2.2" "0123456789-") "new-medium-performing-application - XQuery 2." 0.001)
))

(test-humaneval)
