# 
sub f {
    my($s) = @_;
    my @a = split('', $s);
    my @b = @a;
    for my $c (reverse @a) {
        if ($c eq ' ') {
            pop @b;
        } else {
            last;
        }
    }
    return join('', @b);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hi "),"hi")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
