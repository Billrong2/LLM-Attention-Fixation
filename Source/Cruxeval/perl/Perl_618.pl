# 
sub f {
    my($match, $fill, $n) = @_;
    return substr($fill, 0, $n) . $match;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("9", "8", 2),"89")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
