f <- function(letters, maxsplit) {    
    words <- strsplit(letters, ' ')[[1]]
    paste(words[max(1, length(words) - maxsplit + 1):length(words)], collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('elrts,SS ee', 6), 'elrts,SSee')))
}
test_humaneval()
