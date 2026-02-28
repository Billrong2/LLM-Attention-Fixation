# 
sub f {
    my($text) = @_;
    return join(', ', split('\n', $text));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("BYE
NO
WAY"),"BYE, NO, WAY")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
