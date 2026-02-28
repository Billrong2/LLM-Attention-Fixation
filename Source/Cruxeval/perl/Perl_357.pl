# 
sub f {
    my($s) = @_;
    my @r;
    for (my $i = length($s) - 1; $i >= 0; $i--) {
        push @r, substr($s, $i, 1);
    }
    return join('', @r);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("crew"),"werc")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
