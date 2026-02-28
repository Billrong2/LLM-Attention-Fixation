# 
sub f {
    my($text, $suffix) = @_;
    if ($suffix && substr($text, -length($suffix)) eq $suffix) {
        return substr($text, 0, -length($suffix));
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mathematics", "example"),"mathematics")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
