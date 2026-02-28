# 
sub f {
    my($text) = @_;
    return $text . "#" x (length($text)+1 - length($text));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("the cow goes moo"),"the cow goes moo#")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
