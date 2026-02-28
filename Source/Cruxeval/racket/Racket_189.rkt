#lang racket

(require (only-in srfi/13 string-replace))

(define (f out mapping)
  (let loop ((keys (hash-keys mapping)))
    (if (null? keys)
        out
        (let* ((key (car keys))
               (value (hash-ref mapping key #f))
               (reversed (reverse (cadr value)))
               (updated (hash-set mapping key (list (car value) reversed))))
          (if (regexp-match? #px"\\{\\w\\}" out)
              (loop (cdr keys))
              (f out updated))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "{{{{}}}}" #hash()) "{{{{}}}}" 0.001)
))

(test-humaneval)
