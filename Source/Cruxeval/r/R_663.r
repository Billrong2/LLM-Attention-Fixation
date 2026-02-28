f <- function(container, cron) {    if (!(cron %in% container)) {
        return(container)
    }
    pref <- container[1:(which(container == cron) - 1)]
    suff <- container[(which(container == cron) + 1):length(container)]
    return(c(pref, suff))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(), 2), c())))
}
test_humaneval()
