# 
sub f {
    my($haystack, $needle) = @_;
    for my $i (reverse 0..index($haystack, $needle)) {
        if (substr($haystack, $i) eq $needle) {
            return $i;
        }
    }
    return -1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("345gerghjehg", "345"),-1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
