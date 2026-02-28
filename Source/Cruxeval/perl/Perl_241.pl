# 
sub f {
    my($postcode) = @_;
    return substr($postcode, index($postcode, 'C'));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ED20 CW"),"CW")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
