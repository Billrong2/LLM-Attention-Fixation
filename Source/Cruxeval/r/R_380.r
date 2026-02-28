f <- function(text, delimiter) {
    # Find the last occurrence of the delimiter
    last_pos <- max(gregexpr(delimiter, text, fixed = TRUE)[[1]])
    if (last_pos == -1) {
        return(text)
    }
    # Split the text into three parts
    before <- substr(text, 1, last_pos - 1)
    after <- substr(text, last_pos + nchar(delimiter), nchar(text))
    return(paste0(before, after))
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('xxjarczx', 'x'), 'xxjarcz')))
}
test_humaneval()
