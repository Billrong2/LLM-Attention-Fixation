# 
sub f {
    my($text) = @_;
    my @values = split / /, $text;
    return "$$values[0]y, $$values[1]x, $$values[2]r, $$values[3]p";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("python ruby c javascript"),"${first}y, ${second}x, ${third}r, ${fourth}p")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
