# 
sub f {
    my($text, $tab_size) = @_;
    my $res = '';
    $text =~ s/\t/ ' ' x ($tab_size-1) /ge;
    for (my $i = 0; $i < length($text); $i++) {
        if (substr($text, $i, 1) eq ' ') {
            $res .= '|';
        } else {
            $res .= substr($text, $i, 1);
        }
    }
    return $res;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("	a", 3),"||a")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
