f <- function(s, amount) {    
    paste((paste(rep('z', amount - nchar(s)), collapse = "")), s, sep = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abc', 8), 'zzzzzabc')))
}
test_humaneval()
