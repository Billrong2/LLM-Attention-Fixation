# 
sub f {
    my($text) = @_;
    my @ls = split('', $text);
    for my $i (0..$#ls) {
        if ($ls[$i] ne '+') {
            splice(@ls, $i, 0, '*', '+');
            last;
        }
    }
    return join('+', @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("nzoh"),"*+++n+z+o+h")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
