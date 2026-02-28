f <- function(text) {    nums <- unlist(strsplit(gsub("[^0-9]", "", text), ""))
    stopifnot(length(nums) > 0)
    paste(nums, collapse = "")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('-123   \t+314'), '123314')))
}
test_humaneval()
