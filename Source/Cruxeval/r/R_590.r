f <- function(text) {    for (i in 10:1) {
        text <- gsub(paste0("^", i), "", text)
    }
    text
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('25000   $'), '5000   $')))
}
test_humaneval()
