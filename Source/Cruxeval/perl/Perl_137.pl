# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = 0;
    
    for my $i (0 .. $#nums) {
        if (@nums == 0) {
            last;
        }
        if ($count % 2 == 0) {
            pop @nums;
        } else {
            shift @nums;
        }
        $count += 1;
    }
    
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 2, 0, 0, 2, 3]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
