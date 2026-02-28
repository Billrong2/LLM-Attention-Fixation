# 
sub f {
    my($name) = @_;
    return '| ' . join(' ', split(' ', $name)) . ' |';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("i am your father"),"| i am your father |")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
