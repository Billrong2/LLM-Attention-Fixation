f <- function(text, m, n) {
    text <- paste0(text, substr(text, 1, m), substr(text, n + 1, nchar(text)))
    result <- ""
    for (i in n:(nchar(text) - m - 1)) {
        result <- paste0(substr(text, i + 1, i + 1), result)
    }
    return(result)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abcdefgabc', 1, 2), 'bagfedcacbagfedc')))
}
test_humaneval()
