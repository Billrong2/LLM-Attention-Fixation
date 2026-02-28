# 
sub f {
    my($n, $s) = @_;
    if ($s =~ /^$n/) {
        my ($pre, $suffix) = split(/$n/, $s, 2);
        return $pre . $n . substr($s, length($n));
    }
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("xqc", "mRcwVqXsRDRb"),"mRcwVqXsRDRb")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
