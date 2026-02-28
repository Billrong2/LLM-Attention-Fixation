#lang racket

(define (f input_string)
  (define table (list #\a #\i #\o #\e #\i #\o #\u #\u #\a))
  (let loop ()
    (when (or (string-contains? input_string "a")
              (string-contains? input_string "A"))
      (set! input_string (bytes->string/utf-8 (string->bytes/latin-1 input_string table))))
    (when (or (string-contains? input_string "a")
              (string-contains? input_string "A"))
      (loop)))
  input_string)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "biec") "biec" 0.001)
))

(test-humaneval)
