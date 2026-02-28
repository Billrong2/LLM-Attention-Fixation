f <- function(text) {    text <- gsub('-', '', text)
    text <- tolower(text)
    d <- table(strsplit(text, '')[[1]])
    d <- sort(d)
    return(as.vector(d))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('x--y-z-5-C'), c(1, 1, 1, 1, 1))))
}
test_humaneval()
