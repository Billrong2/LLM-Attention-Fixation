# 
sub f {
    my($array, $num) = @_;
    my $reverse = 0;
    if ($num < 0) {
        $reverse = 1;
        $num *= -1;
    }
    my @array = reverse @$array;
    @array = (@array) x $num;
    my $l = scalar @array;
    
    if ($reverse) {
        @array = reverse @array;
    }
    return \@array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2], 1),[2, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
