f <- function(text) {   
    ls = strsplit(text, "")[[1]]
    length = length(ls)
    for (i in 1:length){
        ls = append(ls, ls[i], i)
    }
    paste(ls, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('hzcw'), 'hhhhhzcw')))
}
test_humaneval()
