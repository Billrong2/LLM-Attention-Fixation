# 
sub f {
    my($text) = @_;
    my @ls = split(//, $text);
    my $total = (length($text) - 1) * 2;
    for my $i (1..$total) {
        if ($i % 2) {
            push(@ls, '+');
        } else {
            unshift(@ls, '+');
        }
    }
    return join('', @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("taole"),"++++taole++++")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
