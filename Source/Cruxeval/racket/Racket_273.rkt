#lang racket

(define (string-reverse str)
  (list->string (reverse (string->list str))))

(define (char-count str char)
  (length (filter (lambda (c) (char=? c char)) (string->list str))))

(define (f name)
  (define new-name "")
  (define reversed-name (string-reverse name))
  (let loop ([i 0])
    (when (< i (string-length reversed-name))
      (define n (string-ref reversed-name i))
      (if (and (not (char=? n #\.)) (< (char-count new-name #\.) 2))
          (begin
            (set! new-name (string-append (string n) new-name))
            (loop (+ i 1)))
          new-name)))
  new-name)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate ".NET") "NET" 0.001)
))

(test-humaneval)
