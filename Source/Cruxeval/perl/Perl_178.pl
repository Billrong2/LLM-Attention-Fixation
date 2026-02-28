# 
sub f {
    my($array, $n) = @_;
    return [@{$array}[$n..$#{$array}]];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 0, 1, 2, 2, 2, 2], 4),[2, 2, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
