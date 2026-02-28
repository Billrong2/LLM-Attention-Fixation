# 
sub f {
    my($s, $c) = @_;
    my @s = split(' ', $s);
    return $c . "  " . join("  ", reverse(@s));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Hello There", "*"),"*  There  Hello")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
