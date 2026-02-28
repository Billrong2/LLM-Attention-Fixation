f <- function(XAAXX, s) {
    count <- gregexpr('XXXX', XAAXX, fixed = TRUE)
    count <- length(unlist(count))
    compound <- paste(toupper(substring(s, 1, 1)), tolower(substring(s, 2)), sep = '')
    compound <- paste(rep(compound, count), collapse = '')
    gsub('XXXX', compound, XAAXX, fixed = TRUE)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('aaXXXXbbXXXXccXXXXde', 'QW'), 'aaQwQwQwbbQwQwQwccQwQwQwde')))
}
test_humaneval()
