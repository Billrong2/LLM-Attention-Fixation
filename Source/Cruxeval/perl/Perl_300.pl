# 
sub f {
    my($nums) = @_;
    my $count = 1;
    for my $i ($count..$#$nums - 1) {
        if ($i % 2 == 1) {
            $nums->[$i] = ($nums->[$i] > $nums->[$count - 1]) ? $nums->[$i] : $nums->[$count - 1];
            $count++;
        }
    }
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3]),[1, 2, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
