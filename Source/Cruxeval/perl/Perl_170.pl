# 
sub f {
    my($nums, $number) = @_;
    return scalar(grep { $_ == $number } @$nums);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([12, 0, 13, 4, 12], 12),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
