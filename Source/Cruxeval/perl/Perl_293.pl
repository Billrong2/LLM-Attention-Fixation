# 
sub f {
    my($text) = @_;
    my $s = lc($text);
    for(my $i = 0; $i < length($s); $i++) {
        if (substr($s, $i, 1) eq 'x') {
            return 'no';
        }
    }
    return $text eq uc($text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dEXE"),"no")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
