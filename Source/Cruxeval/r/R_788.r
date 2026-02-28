f <- function(text, suffix) {    if (substring(suffix, 1, 1) == "/") {
        return(paste0(text, substring(suffix, 2)))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hello.txt', '/'), 'hello.txt')))
}
test_humaneval()
