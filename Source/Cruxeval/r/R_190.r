f <- function(text) {    short <- ''
    for (c in strsplit(text, '')[[1]]) {
        if (grepl('[a-z]', c)) {
            short <- paste0(short, c)
        }
    }
    return(short)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('980jio80jic kld094398IIl '), 'jiojickldl')))
}
test_humaneval()
