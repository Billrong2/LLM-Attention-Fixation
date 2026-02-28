f <- function(text) {    length <- nchar(text) %/% 2
    left_half <- substr(text, 1, length)
    right_half <- substring(text, length + 1, nchar(text))
    paste0(left_half, rev(strsplit(right_half, "")[[1]]), collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('n'), 'n')))
}
test_humaneval()
