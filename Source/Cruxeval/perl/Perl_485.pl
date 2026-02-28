# 
sub f {
    my($tokens) = @_;
    my @tokens = split(' ', $tokens);
    if (scalar @tokens == 2) {
        @tokens = reverse @tokens;
    }
    my $result = sprintf("%-5s %-5s", $tokens[0], $tokens[1]);
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("gsd avdropj"),"avdropj gsd  ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
