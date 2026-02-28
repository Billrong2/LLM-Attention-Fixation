f <- function(text, characters) {    for (i in 1:length(characters)) {
        text <- gsub(paste0("([", characters[i], "])+$"), "", text)
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('r;r;r;r;r;r;r;r;r', 'x.r'), 'r;r;r;r;r;r;r;r;')))
}
test_humaneval()
