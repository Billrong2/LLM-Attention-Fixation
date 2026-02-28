sub f {
    my($items) = @_;
    my @result;
    for my $number (@$items) {
        my %d = @$items;
        my ($k) = keys %d;
        delete $d{$k};
        push @result, {%d};
        @$items = %d;
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[1, "pos"]]),[{}])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
