# 
sub f {
    my($d, $k) = @_;
    my %new_d;
    foreach my $key (keys %$d) {
        my $val = $d->{$key};
        if ($key < $k) {
            $new_d{$key} = $val;
        }
    }
    return \%new_d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({1 => 2, 2 => 4, 3 => 3}, 3),{1 => 2, 2 => 4})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
