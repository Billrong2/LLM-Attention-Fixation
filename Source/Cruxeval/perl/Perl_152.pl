# 
sub f {
    my($text) = @_;
    my $n = 0;
    for my $char (split //, $text) {
        $n++ if $char =~ /[A-Z]/;
    }
    return $n;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("AAAAAAAAAAAAAAAAAAAA"),20)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
