# 
sub f {
    my($x) = @_;
    my $a = 0;
    my @words = split(' ', $x);
    foreach my $i (@words) {
        $a += length(sprintf("%0*d", length($i) * 2, $i));
    }
    return $a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("999893767522480"),30)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
