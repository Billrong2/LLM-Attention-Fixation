# 
sub f {
    my($ets) = @_;
    while (my($k, $v) = each %$ets) {
        $ets->{$k} = $v**2;
        delete $ets->{$k};
    }
    return $ets;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
