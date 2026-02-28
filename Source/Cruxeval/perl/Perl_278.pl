# 
sub f {
    my($array1, $array2) = @_;
    my %result;
    foreach my $key (@$array1) {
        $result{$key} = [grep { $key * 2 > $_ } @$array2];
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 132], [5, 991, 32, 997]),{0 => [], 132 => [5, 32]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
