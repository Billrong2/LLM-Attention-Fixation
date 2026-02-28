f <- function(sentences) {    if(all(sapply(strsplit(sentences, '\\.'), function(sentence) all(grepl('^\\d+$', sentence))))){
        return('oscillating')
    } else {
        return('not oscillating')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('not numbers'), 'not oscillating')))
}
test_humaneval()
