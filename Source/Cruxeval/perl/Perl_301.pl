# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    for my $i (-$count+1..-1) {
        push @nums, $nums[$i], $nums[$i];
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 6, 2, -1, -2]),[0, 6, 2, -1, -2, 6, 6, -2, -2, -2, -2, -2, -2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
