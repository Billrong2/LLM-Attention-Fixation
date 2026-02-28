f <- function() {    d <- list(
        Russia = list(c('Moscow', 'Russia'), c('Vladivostok', 'Russia')),
        Kazakhstan = list(c('Astana', 'Kazakhstan'))
    )
    return(names(d))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(), c('Russia', 'Kazakhstan'))))
}
test_humaneval()
