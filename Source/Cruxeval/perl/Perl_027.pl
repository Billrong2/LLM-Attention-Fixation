# 
sub f {
    my($w) = @_;
    my @ls = split(//, $w);
    my $omw = '';
    while (scalar @ls > 0) {
        $omw .= shift @ls;
        if (scalar @ls * 2 > length($w)) {
            return substr($w, scalar @ls) eq $omw;
        }
    }
    return 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("flak"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
