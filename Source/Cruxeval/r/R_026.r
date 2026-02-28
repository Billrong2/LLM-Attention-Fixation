f <- function(items, target) {    items_split <- unlist(strsplit(items, " "))
    for (i in 1:length(items_split)) {
        if (grepl(items_split[i], target)) {
            return(i)
        }
        if (grepl("\\.$", items_split[i]) | grepl("^\\.", items_split[i])) {
            return('error')
        }
    }
    return(".")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qy. dg. rnvprt rse.. irtwv tx..', 'wtwdoacb'), 'error')))
}
test_humaneval()
