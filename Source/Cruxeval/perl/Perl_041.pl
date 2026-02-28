# 
sub f {
    my($array, $values) = @_;
    my @array = reverse(@$array);
    foreach my $value (@$values) {
        splice(@array, int(@array) / 2, 0, $value);
    }
    @array = reverse(@array);
    return \@array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([58], [21, 92]),[58, 92, 21])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
