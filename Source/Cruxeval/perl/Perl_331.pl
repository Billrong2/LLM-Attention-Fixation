# 
sub f {
    my($strand, $zmnc) = @_;
    my $poz = index($strand, $zmnc);
    while ($poz != -1) {
        $strand = substr($strand, $poz + 1);
        $poz = index($strand, $zmnc);
    }
    return rindex($strand, $zmnc);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("", "abc"),-1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
