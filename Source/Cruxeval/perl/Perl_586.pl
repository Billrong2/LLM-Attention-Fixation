# 
sub f {
    my($text, $char) = @_;
    return rindex($text, $char);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("breakfast", "e"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
