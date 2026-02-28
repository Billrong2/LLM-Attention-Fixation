f <- function(text) {    text <- unlist(strsplit(text, ','))
    text <- text[-1]
    idx <- match('T', text)
    text <- c('T', text[-idx])
    paste(c('T', paste(text, collapse=',')), collapse=',')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Dmreh,Sspp,T,G ,.tB,Vxk,Cct'), 'T,T,Sspp,G ,.tB,Vxk,Cct')))
}
test_humaneval()
