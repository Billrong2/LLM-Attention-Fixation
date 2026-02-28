# 
sub f {
    my($text, $suffix) = @_;
    if ($suffix && $text && substr($text, -length($suffix)) eq $suffix) {
        return substr($text, 0, -length($suffix));
    } else {
        return $text;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("spider", "ed"),"spider")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
