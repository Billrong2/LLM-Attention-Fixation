# 
sub f {
    my($nums) = @_;
    my @output;
    foreach my $n (@$nums) {
        push @output, (scalar(grep {$_ == $n} @$nums), $n);
    }
    @output = sort {$b <=> $a} @output;
    return @output;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1, 3, 1, 3, 1]),[[4, 1], [4, 1], [4, 1], [4, 1], [2, 3], [2, 3]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
