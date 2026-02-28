# 
sub f {
    my($text, $suffix) = @_;
    if (substr($text, -length($suffix)) eq $suffix) {
        $text = substr($text, 0, -1) . uc(substr($text, -1, 1));
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("damdrodm", "m"),"damdrodM")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
