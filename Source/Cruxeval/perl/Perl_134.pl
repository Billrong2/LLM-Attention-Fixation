# 
sub f {
    my($n) = @_;
    my $t = 0;
    my $b = '';
    my @digits = map {int} split(//, $n);
    foreach my $d (@digits) {
        if ($d == 0) {
            $t += 1;
        } else {
            last;
        }
    }
    for (my $i = 0; $i < $t; $i++) {
        $b .= '1' . '0' . '4';
    }
    $b .= $n;
    return $b;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(372359),"372359")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
