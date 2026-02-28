# 
sub f {
    my($nums, $delete) = @_;
    my @result = grep { $_ != $delete } @$nums;
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([4, 5, 3, 6, 1], 5),[4, 3, 6, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
