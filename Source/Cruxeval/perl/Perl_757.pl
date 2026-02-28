# 
sub f {
    my($text, $char, $replace) = @_;
    $text =~ s/$char/$replace/g;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a1a8", "1", "n2"),"an2a8")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
