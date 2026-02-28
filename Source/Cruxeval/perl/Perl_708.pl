# 
sub f {
    my($string) = @_;
    my @l = split(//, $string);
    for my $i (reverse(0..$#l)) {
        if ($l[$i] ne ' ') {
            last;
        }
        splice(@l, $i, 1);
    }
    return join('', @l);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("    jcmfxv     "),"    jcmfxv")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
