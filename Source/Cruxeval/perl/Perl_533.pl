# 
sub f {
    my($query, $base) = @_;
    my($query, $base) = @_;
    my $net_sum = 0;
    foreach my $key (keys %$base) {
        my $val = $base->{$key};
        if (substr($key, 0, 1) eq $query && length($key) == 3) {
            $net_sum -= $val;
        } elsif (substr($key, -1) eq $query && length($key) == 3) {
            $net_sum += $val;
        }
    }
    return $net_sum;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a", {}),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
