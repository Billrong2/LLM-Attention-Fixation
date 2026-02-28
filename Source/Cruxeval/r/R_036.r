f <- function(text, chars) {
    sub(paste0(chars, '$'), '', text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ha', ''), 'ha')))
}
test_humaneval()
