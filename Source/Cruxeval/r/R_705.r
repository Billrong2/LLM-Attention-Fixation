f <- function(cities, name) {
    if (name == "") {
        return(cities)
    }
    if (name != "" && name != "cities") {
        return(c())
    }
    return(paste0(name, cities))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('Sydney', 'Hong Kong', 'Melbourne', 'Sao Paolo', 'Istanbul', 'Boston'), 'Somewhere '), c())))
}
test_humaneval()
