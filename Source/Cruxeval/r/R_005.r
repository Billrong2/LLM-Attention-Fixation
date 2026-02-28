f <- function(text, lower, upper) {    count <- 0
    new_text <- vector(mode = "character", length = nchar(text))
    for (i in 1:nchar(text)) {
        char <- substr(text, i, i)
        char <- ifelse(is.numeric(char), lower, upper)
        if (char %in% c("p", "C")) {
            count <- count + 1
        }
        new_text[i] <- char
    }
    return(list(count, paste(new_text, collapse = "")))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('DSUWeqExTQdCMGpqur', 'a', 'x'), list(0, 'xxxxxxxxxxxxxxxxxx'))))
}
test_humaneval()
