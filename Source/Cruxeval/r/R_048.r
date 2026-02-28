f <- function(names) {    if (length(names) == 0) {
        return("")
    }
    smallest <- names[1]
    for (name in names[-1]) {
        if (name < smallest) {
            smallest <- name
        }
    }
    names <- names[names != smallest]
    return(paste0(smallest, collapse = ""))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), '')))
}
test_humaneval()
