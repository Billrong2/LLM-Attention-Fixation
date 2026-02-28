# 
sub f {
    my($dict) = @_;
    my %result = %$dict;
    my @remove_keys;
    foreach my $k (keys %$dict) {
        my $v = $dict->{$k};
        if (exists $dict->{$v}) {
            push @remove_keys, $k;
        }
    }
    foreach my $k (@remove_keys) {
        delete $result{$k};
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({-1 => -1, 5 => 5, 3 => 6, -4 => -4}),{3 => 6})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
