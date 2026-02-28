# 
sub f {
    my($num) = @_;
    my $s = '<' x 10;
    if ($num % 2 == 0) {
        return $s;
    } else {
        return $num - 1;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(21),20)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
