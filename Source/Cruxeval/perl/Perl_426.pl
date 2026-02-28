# 
sub f {
    my($numbers, $elem, $idx) = @_;
    splice(@{$numbers}, $idx, 0, $elem);
    return $numbers;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3], 8, 5),[1, 2, 3, 8])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
