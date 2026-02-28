# 
sub f {
    my($arr) = @_;
    return [reverse @$arr];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 0, 1, 9999, 3, -5]),[-5, 3, 9999, 1, 0, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
