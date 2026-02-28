f <- function(address) {    suffix_start <- regexpr("@", address)[1] + 1
    if (sum(grepl("\\.", substr(address, suffix_start, nchar(address))) > 1)) {
        address <- substr(address, 1, suffix_start - 1)
    }
    address
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('minimc@minimc.io'), 'minimc@minimc.io')))
}
test_humaneval()
