# 
sub f {
    my($nums) = @_;
    my @reversed = reverse @$nums;
    return @reversed ~~ @$nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 3, 6, 2]),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
