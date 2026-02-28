f <- function(plot, delin) {    if (delin %in% plot) {
        split <- which(plot == delin)
        first <- plot[1:(split-1)]
        second <- plot[(split+1):length(plot)]
        return(c(first, second))
    } else {
        return(plot)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 4), 3), c(1, 2, 4))))
}
test_humaneval()
