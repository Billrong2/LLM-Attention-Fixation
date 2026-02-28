# 
sub f {
    my($nums) = @_;
    my @nums = sort { $a <=> $b } @$nums;
    my $n = @nums;
    my @new_nums = ($nums[int($n/2)]);
    
    if ($n % 2 == 0) {
        @new_nums = ($nums[int($n/2) - 1], $nums[int($n/2)]);
    }
    
    for my $i (0..int($n/2)-1) {
        unshift(@new_nums, $nums[$n-$i-1]);
        push(@new_nums, $nums[$i]);
    }
    return \@new_nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1]),[1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
