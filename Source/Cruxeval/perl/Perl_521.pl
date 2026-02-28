# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $m = 0;
    foreach my $num (@nums) {
        $m = $num if $num > $m;
    }
    for (my $i = 0; $i < $m; $i++) {
        @nums = reverse @nums;
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([43, 0, 4, 77, 5, 2, 0, 9, 77]),[77, 9, 0, 2, 5, 77, 4, 0, 43])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
