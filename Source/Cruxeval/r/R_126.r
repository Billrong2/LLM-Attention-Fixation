f <- function(text) {
    parts <- strsplit(text, "o", fixed = TRUE)[[1]]
    if (length(parts) == 1) {
        return(paste0("-", text))
    } else {
        return(paste0(parts[1], "o", parts[1], "o", parts[2]))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('kkxkxxfck'), '-kkxkxxfck')))
}
test_humaneval()
