f <- function(text, pattern) {
    cites <- c(nchar(substring(text, regexpr(pattern, text) + nchar(pattern))))
    for (char in strsplit(text, '')[[1]]) {
        if (char == pattern) {
            cites <- c(cites, nchar(substring(text, regexpr(pattern, text) + nchar(pattern))))
        }
    }
    return(cites)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('010100', '010'), c(3))))
}
test_humaneval()
