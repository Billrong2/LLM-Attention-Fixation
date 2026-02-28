#lang racket

(require srfi/1)

(define (f text)
  (define texts (string-split text))
  (if (null? texts)
      "nada"
      (let ((xtexts (filter (lambda (t) (and (string->ascii? t) (not (member t '("nada" "0"))))) texts)))
        (if (null? xtexts)
            "nada"
            (apply max-length-string xtexts)))))

(define (string->ascii? s)
  (andmap (lambda (c) (< (char->integer c) 128))
          (string->list s)))

(define (max-length-string . strs)
  (foldr (lambda (s acc)
           (if (> (string-length s) (string-length acc))
               s
               acc))
         ""
         strs))

(require rackunit)

(define (test-f) 
  (let (( candidate f))
    (check-equal? (candidate "example") "example")
))

(test-f)
```
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "") "nada" 0.001)
))

(test-humaneval)
