f <- function(stg, tabs) {    for (tab in tabs) {
        stg <- gsub(paste0(tab, "$"), "", stg)
    }
    stg
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('31849 let it!31849 pass!', c('3', '1', '8', ' ', '1', '9', '2', 'd')), '31849 let it!31849 pass!')))
}
test_humaneval()
