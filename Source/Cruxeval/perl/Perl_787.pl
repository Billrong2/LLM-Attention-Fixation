# 
sub f {
    my($text) = @_;
    if (length($text) == 0) {
        return '';
    }
    $text = lc($text);
    return ucfirst($text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("xzd"),"Xzd")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
