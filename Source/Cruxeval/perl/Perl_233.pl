# 
sub f {
    my($xs) = @_;
    for my $idx (reverse (-1-$#$xs) .. 0) {
        unshift @$xs, splice @$xs, 0, 1;
    }
    return $xs;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3]),[1, 2, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
