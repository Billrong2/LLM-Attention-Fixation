f <- function(text, old, new) {    index <- max(regexpr(old, substr(text, 1, regexpr(old, text) - 1), fixed = TRUE))
    result <- strsplit(text, '')[[1]]
    while (index > 0) {
        result[index:(index + nchar(old) - 1)] <- unlist(strsplit(new, ''))
        index <- max(regexpr(old, substr(text, 1, index - 1), fixed = TRUE))
    }
    paste(result, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('jysrhfm ojwesf xgwwdyr dlrul ymba bpq', 'j', '1'), 'jysrhfm ojwesf xgwwdyr dlrul ymba bpq')))
}
test_humaneval()
