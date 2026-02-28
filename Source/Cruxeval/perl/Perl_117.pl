# 
sub f {
    my($numbers) = @_;
    for my $i (0 .. length($numbers) - 1) {
        if (my @counts = $numbers =~ /3/g) {
            if (@counts > 1) {
                return $i;
            }
        }
    }
    return -1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("23157"),-1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
