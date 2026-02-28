#lang racket

(require srfi/13) ; For string-index

(define (f text)
  (let ([uppercase-index (string-index text #\A)])
    (if uppercase-index
        (string-append (substring text 0 uppercase-index)
                       (substring text (string-index (substring text uppercase-index) #\a) (string-length text)))
        (list->string (sort (string->list text) char<?)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "E jIkx HtDpV G") "   DEGHIVjkptx" 0.001)
))

(test-humaneval)
