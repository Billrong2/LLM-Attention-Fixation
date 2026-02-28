# 
sub f {
    my($n) = @_;
    if(index($n, '.') != -1) {
        return int($n)+2.5;
    }
    return $n;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("800"),"800")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
