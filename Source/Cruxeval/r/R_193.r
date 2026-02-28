f <- function(string) {    count <- gregexpr(':', string)[[1]]
    if (length(count) > 1) {
        for (i in 1:(length(count) - 1)) {
            string <- sub(':', '', string)
        }
    }
    return(string)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('1::1'), '1:1')))
}
test_humaneval()
