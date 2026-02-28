# 
sub f {
    my($text, $insert) = @_;
    my @whitespaces = ("\t", "\r", "\v", " ", "\f", "\n");
    my $clean = '';
    for my $char (split //, $text) {
        if ($char ~~ @whitespaces) {
            $clean .= $insert;
        } else {
            $clean .= $char;
        }
    }
    return $clean;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("pi wa", "chi"),"pichiwa")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
