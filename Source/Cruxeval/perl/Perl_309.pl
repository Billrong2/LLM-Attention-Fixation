# 
sub f {
    my($text, $suffix) = @_;
    $text .= $suffix;
    while (substr($text, -length($suffix)) eq $suffix) {
        $text = substr($text, 0, -1);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("faqo osax f", "f"),"faqo osax ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
