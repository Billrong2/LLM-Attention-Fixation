f <- function(ans) {    if (grepl("^\\d+$", ans)) {
        total <- as.numeric(ans) * 4 - 50
        total <- total - length(grep("[^02468]", strsplit(ans, "")[[1]])) * 100
        return(total)
    }
    return('NAN')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('0'), -50)))
}
test_humaneval()
