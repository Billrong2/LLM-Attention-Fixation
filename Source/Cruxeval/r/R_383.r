f <- function(text, chars) {    result <- strsplit(text, '')[[1]]
    while (chars %in% result[(length(result)-2):1] & length(result) > 2) {
        result <- result[-(length(result)-2)]
        result <- result[-(length(result)-2)]
    }
    return(paste(result, collapse = ''))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ellod!p.nkyp.exa.bi.y.hain', '.n.in.ha.y'), 'ellod!p.nkyp.exa.bi.y.hain')))
}
test_humaneval()
