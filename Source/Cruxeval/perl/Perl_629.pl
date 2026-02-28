# 
sub f {
    my($text, $dng) = @_;
    if (index($text, $dng) == -1) {
        return $text;
    }
    if (substr($text, -length($dng)) eq $dng) {
        return substr($text, 0, -length($dng));
    }
    return substr($text, 0, -1) . f(substr($text, 0, -2), $dng);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("catNG", "NG"),"cat")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
