# 
sub f {
    my($text, $sep) = @_;
    my @fields = split /$sep/, $text, 3;
    return \@fields;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a-.-.b", "-."),["a", "", "b"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
