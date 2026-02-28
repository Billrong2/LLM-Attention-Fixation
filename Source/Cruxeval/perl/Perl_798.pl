# 
sub f {
    my($text, $pre) = @_;
    if (index($text, $pre) != 0) {
        return $text;
    }
    return substr($text, length($pre));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("@hihu@!", "@hihu"),"@!")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
