# 
sub f {
    my($text) = @_;
    my $n = index($text, '8');
    return 'x0' x $n;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("sa832d83r xd 8g 26a81xdf"),"x0x0")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
