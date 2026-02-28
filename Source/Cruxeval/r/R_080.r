f <- function(s) {
  paste0(rev(strsplit(trimws(s), '')[[1]]), collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ab        '), 'ba')))
}
test_humaneval()
