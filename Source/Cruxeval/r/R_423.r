f <- function(selfie) {    lo <- length(selfie)
    for (i in seq(lo-1, 1, by = -1)) {
        if (selfie[i] == selfie[1]) {
            selfie <- selfie[-lo]
        }
    }
    return(selfie)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(4, 2, 5, 1, 3, 2, 6)), c(4, 2, 5, 1, 3, 2))))
}
test_humaneval()
