#lang racket

(define (f string code)
  (define t "")
  (with-handlers ([exn:fail? (lambda (exn) t)])
    (let ([t (string->bytes/utf-8 string)])
      (cond [(equal? (bytes-ref t (sub1 (bytes-length t))) (char->integer #\newline))
             (set! t (subbytes t 0 (sub1 (bytes-length t))))]
            [else t])
      (bytes->string/utf-8 t))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "towaru" "UTF-8") "towaru" 0.001)
))

(test-humaneval)
