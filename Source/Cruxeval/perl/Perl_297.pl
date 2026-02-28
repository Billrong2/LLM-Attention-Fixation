# 
sub f {
    my($num) = @_;
    if (0 < $num && $num < 1000 && $num != 6174) {
        return 'Half Life';
    }
    return 'Not found';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(6173),"Not found")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
