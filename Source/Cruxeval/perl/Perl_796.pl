# 
sub f {
    my($str, $toget) = @_;
    if (index($str, $toget) == 0) {
        return substr($str, length($toget));
    } else {
        return $str;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("fnuiyh", "ni"),"fnuiyh")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
