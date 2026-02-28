# 
sub f {
    my($title) = @_;
    return lc($title);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("   Rock   Paper   SCISSORS  "),"   rock   paper   scissors  ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
