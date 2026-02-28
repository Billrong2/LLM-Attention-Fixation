# 
sub f {
    my($nums) = @_;
    for(my $i = 0; $i < scalar(@{$nums}); $i++) {
        if($i % 2 == 0) {
            push @{$nums}, $nums->[$i] * $nums->[$i + 1];
        }
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
