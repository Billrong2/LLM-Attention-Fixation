f <- function(text, prefix) {    idx <- 1
    for (letter in strsplit(prefix, "")[[1]]) {
        if (substr(text, idx, idx) != letter) {
            return(NULL)
        }
        idx <- idx + 1
    }
    substr(text, idx, nchar(text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('bestest', 'bestest'), '')))
}
test_humaneval()
