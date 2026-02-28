# 
sub f {
    my($nums, $odd1, $odd2) = @_;
    while (grep { $_ == $odd1 } @{$nums}) {
        @{$nums} = grep { $_ != $odd1 } @{$nums};
    }
    while (grep { $_ == $odd2 } @{$nums}) {
        @{$nums} = grep { $_ != $odd2 } @{$nums};
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3], 3, 1),[2, 7, 7, 6, 8, 4, 2, 5, 21])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
