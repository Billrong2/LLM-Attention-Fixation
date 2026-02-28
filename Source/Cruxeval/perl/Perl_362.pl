# 
sub f {
    my($text) = @_;
    for my $i (0..length($text)-2) {
        if (lc(substr($text, $i)) eq substr($text, $i)) {
            return substr($text, $i + 1);
        }
    }
    return '';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("wrazugizoernmgzu"),"razugizoernmgzu")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
