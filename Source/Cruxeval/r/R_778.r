f <- function(prefix, text) {    if (startsWith(text, prefix)) {
        return(text)
    } else {
        return(paste0(prefix, text))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('mjs', 'mjqwmjsqjwisojqwiso'), 'mjsmjqwmjsqjwisojqwiso')))
}
test_humaneval()
