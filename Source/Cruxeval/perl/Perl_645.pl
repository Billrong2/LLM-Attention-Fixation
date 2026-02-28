# 
sub f {
    my($nums, $target) = @_;
    my $count = scalar(grep { $_ == 0 } @$nums);
    if ($count) {
        return 0;
    }
    elsif (scalar(grep { $_ == $target } @$nums) < 3) {
        return 1;
    }
    else {
        my $index = firstidx { $_ == $target } @$nums;
        return $index;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1, 1, 2], 3),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
