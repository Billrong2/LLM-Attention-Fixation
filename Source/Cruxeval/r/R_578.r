f <- function(obj) {    for (k in names(obj)) {
        if (obj[[k]] >= 0) {
            obj[[k]] <- -obj[[k]]
        }
    }
    return(obj)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'R'" = 0, "'T'" = 3, "'F'" = -6, "'K'" = 0)), list("'R'" = 0, "'T'" = -3, "'F'" = -6, "'K'" = 0))))
}
test_humaneval()
