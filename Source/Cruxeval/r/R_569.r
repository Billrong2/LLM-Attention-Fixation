f <- function(txt) {    coincidences <- vector("list", length = nchar(txt))
    for (i in seq_len(nchar(txt))) {
        c <- substr(txt, i, i)
        if (c %in% names(coincidences)) {
            coincidences[[c]] <- coincidences[[c]] + 1
        } else {
            coincidences[[c]] <- 1
        }
    }
    sum(unlist(coincidences))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('11 1 1'), 6)))
}
test_humaneval()
