# 
sub f {
    my($text, $value) = @_;
    return substr($text, length($value));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("coscifysu", "cos"),"cifysu")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
