f <- function(text, letter) {    t <- text
    for (alph in strsplit(text, '')[[1]]) {
        t <- gsub(alph, "", t)
    }
    return(length(strsplit(t, '')[[1]]) + 1 - sum(strsplit(t, '')[[1]] == ''))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('c, c, c ,c, c', 'c'), 1)))
}
test_humaneval()
