f <- function(text) {    
    topic <- sub('\\|.*', '', text)
    problem <- ifelse(sub('.*\\|', '', text) == 'r', gsub('u', 'p', topic), sub('.*\\|', '', text))
    return(c(topic, problem))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('|xduaisf'), c('', 'xduaisf'))))
}
test_humaneval()
