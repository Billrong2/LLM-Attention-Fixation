f <- function(s1, s2) {    position <- 1
    count <- 0
    while (position > 0) {
        position <- regexpr(s2, substr(s1, position, nchar(s1)))[[1]]
        count <- count + 1
        position <- position + 1
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('xinyyexyxx', 'xx'), 2)))
}
test_humaneval()
