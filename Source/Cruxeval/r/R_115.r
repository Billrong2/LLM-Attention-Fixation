f <- function(text) {    res <- c()
    for (ch in charToRaw(text)) {
        if (as.integer(ch) == 61) {
            break
        }
        if (as.integer(ch) != 0) {
            res <- c(res, paste(as.integer(ch), '; ', sep = ''))
        }
    }
    paste('b\'', paste(res, collapse = ''), '\'', sep = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('os||agx5'), "b'111; 115; 124; 124; 97; 103; 120; 53; '")))
}
test_humaneval()
