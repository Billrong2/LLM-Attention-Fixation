# 
sub f {
    my($n) = @_;
    foreach my $i (split(//, $n)) {
        if ($i !~ /\d/) {
            $n = -1;
            last;
        }
    }
    return $n;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("6 ** 2"),-1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
