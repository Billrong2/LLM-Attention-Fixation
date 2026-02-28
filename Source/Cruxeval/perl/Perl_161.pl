# 
sub f {
    my($text, $value) = @_;
    my ($left, $right) = split /$value/, $text, 2;
    return $right . $left;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("difkj rinpx", "k"),"j rinpxdif")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
