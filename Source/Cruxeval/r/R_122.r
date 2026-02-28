f <- function(string) {    if (substring(string, 1, 4) != 'Nuva') {
        return('no')
    } else {
        return(trimws(string, which = 'right'))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Nuva?dlfuyjys'), 'Nuva?dlfuyjys')))
}
test_humaneval()
