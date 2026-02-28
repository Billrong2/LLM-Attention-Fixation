f <- function(w) {    
    chars <- strsplit(w, "")[[1]]
    rev_w <- paste(rev(strsplit(w, "")[[1]]), collapse="")
    for (i in 1:floor(nchar(w)/2)) {
        if (substr(w, 1, i) == substr(rev_w, 1, i)) {
            return(TRUE)
        }
    }
    return(FALSE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('flak'), FALSE)))
}
test_humaneval()
