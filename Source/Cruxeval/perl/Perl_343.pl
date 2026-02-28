# 
sub f {
    my($array, $elem) = @_;
    push @{$array}, @{$elem};
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[1, 2, 3], [1, 2], 1], [[1, 2, 3], 3, [2, 1]]),[[1, 2, 3], [1, 2], 1, [1, 2, 3], 3, [2, 1]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
