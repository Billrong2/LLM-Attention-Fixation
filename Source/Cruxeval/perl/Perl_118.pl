# 
sub f {
    my($text, $chars) = @_;
    my $num_applies = 2;
    my $extra_chars = '';
    foreach my $i (0..$num_applies-1) {
        $extra_chars .= $chars;
        $text =~ s/\Q$extra_chars\E//g;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("zbzquiuqnmfkx", "mk"),"zbzquiuqnmfkx")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
