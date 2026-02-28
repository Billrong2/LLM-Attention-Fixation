# 
sub f {
    my($text) = @_;
    my $result = '';
    for (my $i = length($text)-1; $i >= 0; $i--) {
        $result .= substr($text, $i, 1);
    }
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("was,"),",saw")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
