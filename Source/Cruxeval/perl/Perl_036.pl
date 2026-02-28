# 
sub f {
    my($text, $chars) = @_;
    return $text if !$text;
    return substr($text, 0, rindex($text, $chars) + length($chars));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ha", ""),"ha")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
