# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $count = scalar @nums;
    for my $num (2..$count-1) {
        @nums = sort {$a <=> $b} @nums;
    }
    return \@nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-6, -5, -7, -8, 2]),[-8, -7, -6, -5, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
