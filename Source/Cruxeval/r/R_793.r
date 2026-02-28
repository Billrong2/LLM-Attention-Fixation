f <- function(lst, start, end) {    count <- 0
    for (i in start:(end - 1)) {
        for (j in i:(end - 1)) {
            if (lst[i + 1] != lst[j + 1]) {
                count <- count + 1
            }
        }
    }
    return(count)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 4, 3, 2, 1), 0, 3), 3)))
}
test_humaneval()
