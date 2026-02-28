# 
sub f {
    my($text, $prefix) = @_;
    while (substr($text, 0, length($prefix)) eq $prefix) {
        $text = substr($text, length($prefix)) || $text;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ndbtdabdahesyehu", "n"),"dbtdabdahesyehu")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
