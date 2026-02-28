# 
sub f {
    my($text, $characters) = @_;
    for my $i (split //, $characters) {
        my $char = $i;
        $text =~ s/[$char]*$//;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("r;r;r;r;r;r;r;r;r", "x.r"),"r;r;r;r;r;r;r;r;")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
