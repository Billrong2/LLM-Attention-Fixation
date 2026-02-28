f <- function(s, c) {    s <- strsplit(s, " ")[[1]]
    return(paste0(c, "  ", paste0(rev(s), collapse = "  ")))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Hello There', '*'), '*  There  Hello')))
}
test_humaneval()
