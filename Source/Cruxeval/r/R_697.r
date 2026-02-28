f <- function(s, sep) {    sep_index <- regexpr(sep, s)[1]
    prefix <- substr(s, 1, sep_index - 1)
    middle <- substr(s, sep_index, sep_index + nchar(sep) - 1)
    right_str <- substr(s, sep_index + nchar(sep), nchar(s))
    return(c(prefix, middle, right_str))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('not it', ''), c('', '', 'not it'))))
}
test_humaneval()
