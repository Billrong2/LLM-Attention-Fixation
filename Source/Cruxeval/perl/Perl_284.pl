# 
sub f {
    my($text, $prefix) = @_;
    my $idx = 0;
    foreach my $letter (split(//, $prefix)) {
        if (substr($text, $idx, 1) ne $letter) {
            return undef;
        }
        $idx++;
    }
    return substr($text, $idx);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("bestest", "bestest"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
