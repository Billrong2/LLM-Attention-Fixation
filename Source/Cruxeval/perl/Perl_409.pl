# 
sub f {
    my($text, $char) = @_;
    if($text) {
        $text =~ s/^$char//;
        $text =~ s/^$text[-1]//;
        $text = substr($text, 0, -1) . uc(substr($text, -1, 1));
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("querist", "u"),"querisT")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
