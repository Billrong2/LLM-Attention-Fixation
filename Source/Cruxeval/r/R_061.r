f <- function(text) {    texts <- unlist(strsplit(text, "\\s+"))
    xtexts <- texts[texts != 'nada' & texts != '0' & grepl("^[[:alnum:][:punct:]]+$", texts)]
    if (length(xtexts) > 0) {
        return(xtexts[which.max(nchar(xtexts))])
    } else {
        return('nada')
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(''), 'nada')))
}
test_humaneval()
