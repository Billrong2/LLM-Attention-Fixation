# 
sub f {
    my($d) = @_;
    my @result;
    my @keys = keys %$d;
    my $a = my $b = 0;
    while (%$d) {
        my $key = $keys[$a];
        push @result, delete $d->{$key};
        ($a, $b) = ($b, ($b+1) % scalar @keys);
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
