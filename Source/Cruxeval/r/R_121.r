f <- function(s) {    nums <- paste0(unlist(strsplit(s, split = ""))[grepl('[0-9]', unlist(strsplit(s, split = "")))] , collapse = "")
    
    if (nums == '') {
        return('none')
    }
    
    nums <- unlist(strsplit(nums, split = ","))
    m <- max(as.numeric(nums))
    return(as.character(m))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('01,001'), '1001')))
}
test_humaneval()
