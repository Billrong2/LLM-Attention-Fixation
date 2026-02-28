f <- function(base, delta) {    for (j in seq_along(delta)) {
        for (i in seq_along(base)) {
            if (base[i] == delta[j][1]) {
                stopifnot(delta[j][2] != base[i])
                base[i] <- delta[j][2]
            }
        }
    }
    base
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('gloss', 'banana', 'barn', 'lawn'), c()), c('gloss', 'banana', 'barn', 'lawn'))))
}
test_humaneval()
