# 
sub f {
    my($nums, $target) = @_;
    my @nums = @{$nums};
    my $cnt = grep { $_ == $target } @nums;
    return $cnt * 2;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1], 1),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
