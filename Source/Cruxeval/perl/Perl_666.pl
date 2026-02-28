# 
sub f {
    my($d1, $d2) = @_;
    my $mmax = 0;
    foreach my $k1 (keys %{$d1}) {
        my $p = scalar(@{$d1->{$k1}}) + scalar(@{$d2->{$k1} // []});
        if ($p) {
            if ($p > $mmax) {
                $mmax = $p;
            }
        }
    }
    return $mmax;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({0 => [], 1 => []}, {0 => [0, 0, 0, 0], 2 => [2, 2, 2]}),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
