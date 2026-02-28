f <- function(names) {    count <- length(names)
    numberOfNames <- 0
    for (i in names) {
        if (grepl("^[a-zA-Z]+$", i)) {
            numberOfNames <- numberOfNames + 1
        }
    }
    return(numberOfNames)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('sharron', 'Savannah', 'Mike Cherokee')), 2)))
}
test_humaneval()
