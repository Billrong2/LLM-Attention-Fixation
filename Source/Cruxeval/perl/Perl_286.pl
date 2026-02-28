# 
sub f {
    my($array, $x, $i) = @_;
    my @array = @$array;
    if ($i < -$#array || $i > $#array) {
        return 'no';
    }
    my $temp = $array[$i];
    $array[$i] = $x;
    return \@array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 11, 4),[1, 2, 3, 4, 11, 6, 7, 8, 9, 10])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
