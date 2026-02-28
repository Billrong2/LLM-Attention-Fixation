# 
sub f {
    my($text) = @_;
    my $length = length $text;
    my $half = int($length / 2);
    my $encode = substr($text, 0, $half);
    utf8::encode($encode);
    return substr($text, $half) eq $encode;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("bbbbr"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
