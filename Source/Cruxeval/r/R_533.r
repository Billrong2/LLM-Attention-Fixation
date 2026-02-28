f <- function(query, base) {    net_sum <- 0
    for (key in names(base)) {
        if (substring(key, 1, 1) == query & nchar(key) == 3) {
            net_sum <- net_sum - base[[key]]
        } else if (substring(key, 3, 3) == query & nchar(key) == 3) {
            net_sum <- net_sum + base[[key]]
        }
    }
    return(net_sum)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a', list()), 0)))
}
test_humaneval()
