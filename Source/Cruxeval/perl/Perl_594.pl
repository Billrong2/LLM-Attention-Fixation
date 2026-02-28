# 
sub f {
    my($file) = @_;
    return index($file, "\n");
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("n wez szize lnson tilebi it 504n.
"),33)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
