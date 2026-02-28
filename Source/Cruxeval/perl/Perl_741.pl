# 
sub f {
    my($nums, $p) = @_;
    my @nums = @{$nums};
    my $prev_p = $p - 1;
    if($prev_p < 0){
        $prev_p = scalar @nums - 1;
    }
    return $nums[$prev_p];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6, 8, 2, 5, 3, 1, 9, 7], 6),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
