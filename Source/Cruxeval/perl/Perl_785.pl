# 
sub f {
    my($n) = @_;
    my $streak = '';
    foreach my $c (split('', $n)) {
        $streak .= $c . (' ' x ($c * 2 - length $c));
    }
    return $streak;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(1),"1 ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
