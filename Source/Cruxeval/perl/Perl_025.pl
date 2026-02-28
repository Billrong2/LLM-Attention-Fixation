# 
sub f {
    my($d) = @_;
    my %d = %$d;
    my @keys = keys %d;
    delete $d{$keys[-1]};
    return \%d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"l" => 1, "t" => 2, "x:" => 3}),{"l" => 1, "t" => 2})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
