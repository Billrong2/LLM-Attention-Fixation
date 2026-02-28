# 
sub f {
    my($array) = @_;
    my %d = map { @$_ } @$array;
    foreach my $key (keys %d) {
        my $value = $d{$key};
        if ($value < 0 || $value > 9) {
            return undef;
        }
    }
    return \%d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[8, 5], [8, 2], [5, 3]]),{8 => 2, 5 => 3})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
