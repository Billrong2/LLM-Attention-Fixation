#lang racket

(require srfi/13)

(define (f strand zmnc)
  (let loop ([strand strand]
             [pos (string-contains strand zmnc)])
    (if pos
        (loop (substring strand (+ pos 1) (string-length strand))
              (string-contains strand zmnc))
        (if (string-contains strand zmnc)
            (string-index-right strand zmnc)
            -1))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "" "abc") -1 0.001)
))

(test-humaneval)
