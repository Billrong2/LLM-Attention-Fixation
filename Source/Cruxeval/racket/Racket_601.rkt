#lang racket

(define (f text)
  (define t 5)
  (define tab '())
  (for ([i (in-string text)])
    (if (member (char-downcase i) '(#\a #\e #\i #\o #\u #\y))
        (set! tab (append tab (list (string-upcase (make-string t i)))))
        (set! tab (append tab (list (make-string t i)))))
    )
  (string-join tab " "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "csharp") "ccccc sssss hhhhh AAAAA rrrrr ppppp" 0.001)
))

(test-humaneval)
