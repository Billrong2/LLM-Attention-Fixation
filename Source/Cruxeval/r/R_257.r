f <- function(text) {    ls <- lapply(text, function(x) strsplit(x, "\n", fixed = TRUE)[[1]])
    return(ls)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('Hello World\n"I am String"')), list(c('Hello World', '"I am String"')))))
}
test_humaneval()
