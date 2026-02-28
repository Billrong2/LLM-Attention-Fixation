f <- function(instagram, imgur, wins) {
    photos <- list(instagram, imgur)
    if (all(instagram == imgur)) {
        return(wins)
    } else if (wins == 1) {
        return(photos[[length(photos)]])
    } else {
        photos <- photos[length(photos):1]
        return(photos[[length(photos)]])
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('sdfs', 'drcr', '2e'), c('sdfs', 'dr2c', 'QWERTY'), 0), c('sdfs', 'drcr', '2e'))))
}
test_humaneval()
