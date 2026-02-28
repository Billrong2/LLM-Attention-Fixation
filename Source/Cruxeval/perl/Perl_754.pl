# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    my $width = shift @nums;
    my @formatted_nums = map { sprintf("%0*d", $width, $_) } @nums;
    return \@formatted_nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["1", "2", "2", "44", "0", "7", "20257"]),["2", "2", "44", "0", "7", "20257"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
