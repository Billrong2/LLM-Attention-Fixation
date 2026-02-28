# 
sub f {
    my($nums) = @_;
    foreach my $i (0..$#{$nums}) {
        if ($nums->[$i] % 3 == 0) {
            push @{$nums}, $nums->[$i];
        }
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 3]),[1, 3, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
