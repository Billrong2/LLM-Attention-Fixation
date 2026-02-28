# 
sub f {
    my($text, $length, $index) = @_;
    my @ls = reverse split ' ', $text, $index;
    return join '_', map { substr($_, 0, $length) } @ls;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hypernimovichyp", 2, 2),"hy")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
