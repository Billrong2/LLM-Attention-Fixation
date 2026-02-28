# 
sub f {
    my($var) = @_;
    my $amount = ref($var) eq 'ARRAY' ? scalar(@$var) : 0;
    if(ref($var) eq 'HASH') {
        $amount = scalar(keys %$var);
    }
    my $nonzero = $amount > 0 ? $amount : 0;
    return $nonzero;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(1),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
