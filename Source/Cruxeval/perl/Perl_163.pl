# 
sub f {
    my($text, $space_symbol, $size) = @_;
    my $spaces = $space_symbol x ($size - length($text));
    return $text . $spaces;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("w", "))", 7),"w))))))))))))")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
