f <- function(text, width) {   
    text = substr(text, 1, width)
    paste(strrep('z', ceiling((width - nchar(text))/2)), text, strrep('z', floor((width - nchar(text))/2)), sep='')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('0574', 9), 'zzz0574zz')))
}
test_humaneval()
