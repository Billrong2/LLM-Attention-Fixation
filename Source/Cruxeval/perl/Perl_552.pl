# 
sub f {
    my($d) = @_;
    my %result;
    foreach my $k (keys %$d) {
        my $v = $d->{$k};
        if (ref $k eq 'HASH') {
            foreach my $i (@$v) {
                $result{$i} = $k;
            }
        } else {
            $result{$k} = $v;
        }
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({2 => 0.76, 5 => [3, 6, 9, 12]}),{2 => 0.76, 5 => [3, 6, 9, 12]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
