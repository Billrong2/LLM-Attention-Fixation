# 
sub f {
    my($lst, $i, $n) = @_;
    splice(@{$lst}, $i, 0, $n);
    return $lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([44, 34, 23, 82, 24, 11, 63, 99], 4, 15),[44, 34, 23, 82, 15, 24, 11, 63, 99])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
