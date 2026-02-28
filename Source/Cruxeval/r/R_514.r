f <- function(text) {    words <- unlist(strsplit(text, " "))
    for (item in words) {
        text <- gsub(paste0("-\\b", item, "\\b"), " ", text)
        text <- gsub(paste0("\\b", item, "-"), " ", text)
    }
    text <- gsub("^-|-$", "", text)
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('-stew---corn-and-beans-in soup-.-'), 'stew---corn-and-beans-in soup-.')))
}
test_humaneval()
