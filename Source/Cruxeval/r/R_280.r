f <- function(text) {    g <<- gsub('0', ' ', text)
    field <<- gsub(' ', '', text)
    text <- gsub('1', 'i', text)
    
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('00000000 00000000 01101100 01100101 01101110'), '00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0')))
}
test_humaneval()
