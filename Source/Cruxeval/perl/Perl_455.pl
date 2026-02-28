# 
sub f {
    my($text) = @_;
    my $uppers = 0;
    foreach my $c (split("", $text)) {
        if (uc($c) eq $c) {
            $uppers++;
        }
    }
    return $uppers >= 10 ? uc($text) : $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("?XyZ"),"?XyZ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
