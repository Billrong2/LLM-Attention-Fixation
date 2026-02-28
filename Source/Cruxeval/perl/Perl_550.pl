# 
sub f {
    my($nums) = @_;
    foreach my $i (0..$#{$nums}) {
        splice @{$nums}, $i, 0, $nums->[$i]**2;
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 4]),[1, 1, 1, 1, 2, 4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
