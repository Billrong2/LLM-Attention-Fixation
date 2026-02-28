# 
sub f {
    my($test_str) = @_;
    my $s = $test_str;
    $s =~ s/a/A/g;
    $s =~ s/e/A/g;
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("papera"),"pApArA")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
