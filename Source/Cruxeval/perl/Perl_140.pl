# 
sub f {
    my($st) = @_;
    if (index(lc($st), 'h', rindex(lc($st), 'i')) >= rindex(lc($st), 'i')) {
        return 'Hey';
    } else {
        return 'Hi';
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Hi there"),"Hey")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
