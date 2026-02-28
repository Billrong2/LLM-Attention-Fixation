# 
sub f {
    my($l, $c) = @_;
    return join($c, @$l);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["many", "letters", "asvsz", "hello", "man"], ""),"manylettersasvszhelloman")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
