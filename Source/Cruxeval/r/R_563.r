f <- function(text1, text2) {    nums <- sapply(strsplit(text2, "")[[1]], function(x) nchar(gsub(paste0("[^", x, "]"), "", text1)))
    sum(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('jivespdcxc', 'sx'), 2)))
}
test_humaneval()
