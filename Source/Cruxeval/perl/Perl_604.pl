# 
sub f {
    my($text, $start) = @_;
    return substr($text, 0, length($start)) eq $start;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Hello world", "Hello"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
