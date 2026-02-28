# 
sub f {
    my($n) = @_;
    my @b = split(//, $n);
    for my $i (2..$#b) {
        $b[$i] .= '+';
    }
    return @b;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(44),["4", "4"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
