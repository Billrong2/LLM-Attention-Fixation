f <- function(s) {
    count <- nchar(s) - 1
    reverse_s <- rev(strsplit(s, "")[[1]])
    while (count > 0 && grepl('sea', paste(reverse_s[seq(1, count, by = 2)], collapse = ''), fixed = TRUE) == FALSE) {
        count <- count - 1
        reverse_s <- reverse_s[1:count]
    }
    if(count == 0) return("")
    paste(reverse_s[count:length(reverse_s)], collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('s a a b s d s a a s a a'), '')))
}
test_humaneval()
