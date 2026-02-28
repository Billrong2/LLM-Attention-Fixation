f <- function(text) {    x <- 0
    if (grepl("^[a-z]+$", text)) {
        for (c in strsplit(text, "")[[1]]) {
            if (as.numeric(c) %in% 0:9) {
                x <- x + 1
            }
        }
    }
    return(x)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('591237865'), 0)))
}
test_humaneval()
