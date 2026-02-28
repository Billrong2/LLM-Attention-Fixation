f <- function(s) {    count <- 0
    for (c in strsplit(s, '')[[1]]) {
        if (max(which(strsplit(s, '')[[1]] == c)) != min(which(strsplit(s, '')[[1]] == c))) {
            count <- count + 1
        }
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abca dea ead'), 10)))
}
test_humaneval()
