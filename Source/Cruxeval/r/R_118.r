f <- function(text, chars) {    num_applies <- 2
    extra_chars <- ''
    for (i in 1:num_applies) {
        extra_chars <- paste0(extra_chars, chars)
        text <- gsub(extra_chars, '', text)
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('zbzquiuqnmfkx', 'mk'), 'zbzquiuqnmfkx')))
}
test_humaneval()
