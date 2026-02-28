# 
sub f {
    my($nums) = @_;
    my @asc = @$nums;
    my @desc = reverse @asc;
    @desc = @desc[0..(scalar @desc // 2 - 1)];
    return (@desc, @asc, @desc);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
