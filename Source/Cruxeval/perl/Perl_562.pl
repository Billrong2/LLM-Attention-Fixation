# 
sub f {
    my($text) = @_;
    return uc($text) eq $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("VTBAEPJSLGAHINS"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
