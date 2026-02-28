# 
sub f {
    my($text) = @_;
    return scalar(split('#', (split(':', $text))[0])) - 1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("#! : #!"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
