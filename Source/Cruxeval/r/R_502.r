f <- function(name) {    return(paste(strsplit(name, " ")[[1]], collapse = "*"))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Fred Smith'), 'Fred*Smith')))
}
test_humaneval()
