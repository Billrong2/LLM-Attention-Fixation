f <- function(n) {    n_str <- as.character(n)
    for (n_char in strsplit(n_str, "")[[1]]) {
        if (!(n_char %in% c("0", "1", "2")) && !(as.numeric(n_char) %in% 5:9) ) {
            return(FALSE)
        }
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(1341240312), FALSE)))
}
test_humaneval()
