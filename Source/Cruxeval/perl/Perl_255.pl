# 
sub f {
    my($text, $fill, $size) = @_;
    if ($size < 0) {
        $size = -$size;
    }
    if (length($text) > $size) {
        return substr($text, length($text) - $size);
    }
    return sprintf("%*s", $size, $text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("no asw", "j", 1),"w")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
