f <- function(s) {    count <- 0
    digits <- ""
    for (c in strsplit(s, '')[[1]]) {
        if (grepl("\\d", c)) {
            count <- count + 1
            digits <- paste0(digits, c)
        }
    }
    list(digits, count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qwfasgahh329kn12a23'), list('3291223', 7))))
}
test_humaneval()
