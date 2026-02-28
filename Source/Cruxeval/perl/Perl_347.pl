# 
sub f {
    my($text) = @_;
    my @ls = split('', $text);
    my $length = scalar @ls;
    for my $i (0..$length-1) {
        splice @ls, $i, 0, $ls[$i];
    }
    return join('', @ls) . ' ' x ($length * 2 - length(join('', @ls)));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hzcw"),"hhhhhzcw")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
