f <- function(years) {    a10 <- sum(years <= 1900)
    a90 <- sum(years > 1910)
    
    if (a10 > 3) {
        return(3)
    } else if (a90 > 3) {
        return(1)
    } else {
        return(2)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1872, 1995, 1945)), 2)))
}
test_humaneval()
