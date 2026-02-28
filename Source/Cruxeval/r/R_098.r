f <- function(s) {    words <- strsplit(s, " ")[[1]]
    sum(grepl('^[:upper:]', words))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('SOME OF THIS Is uknowN!'), 1)))
}
test_humaneval()
