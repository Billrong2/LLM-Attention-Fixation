f <- function(text, length, fillchar) {
    size = nchar(text)
    if (size >= length) {
        return(text)
    } else {
        return(paste(c(rep(fillchar, ceiling((length - size) / 2)), text, rep(fillchar, floor((length - size) / 2))), collapse = ''))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('magazine', 25, '.'), '.........magazine........')))
}
test_humaneval()
