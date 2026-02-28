f <- function(chemicals, num) {
    fish <- chemicals[-1]
    chemicals <- rev(chemicals)
    for (i in seq_len(num)) {
        fish <- c(fish, chemicals[2])
        chemicals <- chemicals[-2]
    }
    chemicals <- rev(chemicals)
    return(chemicals)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('lsi', 's', 't', 't', 'd'), 0), c('lsi', 's', 't', 't', 'd'))))
}
test_humaneval()
