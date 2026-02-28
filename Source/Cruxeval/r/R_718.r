f <- function(text) {    t <- text
    text <- gsub(".", "", text)
    paste0(nchar(text), t)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ThisIsSoAtrocious'), '0ThisIsSoAtrocious')))
}
test_humaneval()
