# 
sub f {
    my($nums, $sort_count) = @_;
    @$nums = sort { $a <=> $b } @$nums;
    return [@{$nums}[0..$sort_count-1]];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 2, 3, 4, 5], 1),[1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
