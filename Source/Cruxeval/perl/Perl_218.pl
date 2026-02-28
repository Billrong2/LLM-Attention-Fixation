# 
sub f {
    my($string, $sep) = @_;
    my $cnt = () = $string =~ /$sep/g;
    return scalar reverse(($string . $sep) x $cnt);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("caabcfcabfc", "ab"),"bacfbacfcbaacbacfbacfcbaac")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
