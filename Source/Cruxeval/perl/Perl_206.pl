# 
sub f {
    my($a) = @_;
    return join(' ', split(' ', $a));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(" h e l l o   w o r l d! "),"h e l l o w o r l d!")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
