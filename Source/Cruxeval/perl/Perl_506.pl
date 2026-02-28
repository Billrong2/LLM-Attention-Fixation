# 
sub f {
    my($n) = @_;
    my $p = '';
    if ($n % 2 == 1) {
        $p .= 'sn';
    } else {
        return $n * $n;
    }
    for my $x (1..$n) {
        if ($x % 2 == 0) {
            $p .= 'to';
        } else {
            $p .= 'ts';
        }
    }
    return $p;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(1),"snts")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
