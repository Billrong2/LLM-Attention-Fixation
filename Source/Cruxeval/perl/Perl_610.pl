sub f {
    my($keys, $value) = @_;
    my %d = map { $_ => $value } @$keys;
    my @keys = sort { $a <=> $b } keys %d;
    for my $i (0..$#keys) {
        my $k = $keys[$i];
        if (exists $d{$k} and exists $d{$i+1} and $d{$k} == $d{$i+1}) {
            delete $d{$i+1};
        }
    }
    return \%d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 1, 1], 3),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
