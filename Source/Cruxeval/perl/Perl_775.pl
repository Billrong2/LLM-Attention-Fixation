# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    for my $i (0..int($count/2)-1) {
        ($nums[$i], $nums[$count-$i-1]) = ($nums[$count-$i-1], $nums[$i]);
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 6, 1, 3, 1]),[1, 3, 1, 6, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
