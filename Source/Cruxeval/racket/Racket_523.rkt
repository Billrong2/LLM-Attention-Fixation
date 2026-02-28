#lang racket

(define (f text)
  (define text-list (string->list text))
  (define (replace-spaces lst)
    (if (null? lst)
        '()
        (let ([c (car lst)])
          (if (char-whitespace? c)
              (append (string->list "&nbsp;") (replace-spaces (cdr lst)))
              (cons c (replace-spaces (cdr lst)))))))
  (list->string (replace-spaces text-list)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "   ") "&nbsp;&nbsp;&nbsp;" 0.001)
))

(test-humaneval)
