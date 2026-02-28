#lang racket

(define (f text)
  (- (string-length text) (count-matches text "bot")))

(define (count-matches text pattern)
  (let loop ((start 0) (count 0))
    (let ((i (substring-index text pattern start)))
      (if i
          (loop (+ i 1) (+ count 1))
          count))))

(define (substring-index text pattern start)
  (let ((text-length (string-length text))
        (pattern-length (string-length pattern)))
    (let loop ((i start))
      (cond ((> (+ i pattern-length) text-length) #f)
            ((string=? (substring text i (+ i pattern-length)) pattern) i)
            (else (loop (+ i 1)))))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Where is the bot in this world?") 30 0.001)
))

(test-humaneval)
