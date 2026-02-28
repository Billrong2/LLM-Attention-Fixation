# 
sub f {
    my($array) = @_;
    my @a;
    @{$array} = reverse @{$array};
    foreach my $element (@{$array}) {
        if ($element != 0) {
            push @a, $element;
        }
    }
    @{$array} = reverse @a;
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
