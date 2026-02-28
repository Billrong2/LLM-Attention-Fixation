# 
sub f {
    my($text) = @_;
    return index($text, ',');
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("There are, no, commas, in this text"),9)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
