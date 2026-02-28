# 
sub f {
    my($nums) = @_;
    for(my $i = @{$nums}-1; $i >= 0; $i--) {
        if($nums->[$i] % 2 == 0) {
            splice(@$nums, $i, 1);
        }
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, 3, 3, 7]),[5, 3, 3, 7])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
