f <- function(n, m, num) {    x_list <- seq(n, m)
    j <- 1
    while(TRUE) {
        j <- (j + num) %% length(x_list)
        if (x_list[j] %% 2 == 0) {
            return(x_list[j])
        }
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(46, 48, 21), 46)))
}
test_humaneval()
