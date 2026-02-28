# 
sub f {
    my($nums) = @_;
    @$nums = ();  # clear the array
    foreach my $num (@$nums) {
        push @$nums, $num * 2;  # append the doubled number
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([4, 3, 2, 1, 2, -1, 4, 2]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
