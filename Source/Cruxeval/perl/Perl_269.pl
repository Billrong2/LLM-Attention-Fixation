# 
sub f {
    my($array) = @_;
    my @array = @{$array};
    my $zero_len = (scalar @array - 1) % 3;
    for my $i (0..$zero_len-1) {
        $array[$i] = '0';
    }
    for my $i ($zero_len+1..$#array) {
        splice @array, $i-1, 3, '0', '0', '0';
    }
    return \@array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([9, 2]),["0", 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
