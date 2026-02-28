f <- function(text) {    new_text <- sapply(strsplit(text, '')[[1]], function(c) ifelse(grepl("[0-9]", c), c, "*"))
    paste(new_text, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('5f83u23saa'), '5*83*23***')))
}
test_humaneval()
