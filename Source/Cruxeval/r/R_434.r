f <- function(string) {    
    match <- gregexpr('e', string)
    if (length(unlist(match)) == 0) {
        return("Nuk")
    } else {
        return(tail(unlist(match), 1) - 1)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('eeuseeeoehasa'), 8)))
}
test_humaneval()
