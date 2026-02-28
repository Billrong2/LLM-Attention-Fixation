f <- function(text, comparison) {    length <- nchar(comparison)
    if (length <= nchar(text)) {
        for (i in 1:length) {
            if (substring(comparison, length - i + 1, length - i + 1) != substring(text, nchar(text) - i + 1, nchar(text) - i + 1)) {
                return(i - 1)
            }
        }
    }
    return(length)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('managed', ''), 0)))
}
test_humaneval()
