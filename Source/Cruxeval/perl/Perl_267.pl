# 
sub f {
    my($text, $space) = @_;
    if($space < 0) {
        return $text;
    }
    return substr($text, 0, length($text) / 2 + $space) . ' ' x $space;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("sowpf", -7),"sowpf")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
