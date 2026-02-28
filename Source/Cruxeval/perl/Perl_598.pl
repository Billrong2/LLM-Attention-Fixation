# 
sub f {
    my($text, $n) = @_;
    my $length = length($text);
    return substr($text, $length*($n%4), $length);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abc", 1),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
