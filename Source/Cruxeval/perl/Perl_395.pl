# 
sub f {
    my($s) = @_;
    for my $i (0 .. length($s) - 1) {
        if (substr($s, $i, 1) =~ /\d/) {
            return $i + ($s[$i] eq '0');
        } elsif ($s[$i] eq '0') {
            return -1;
        }
    }
    return -1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("11"),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
