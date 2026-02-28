# 
sub f {
    my($s1, $s2) = @_;
    my $position = 1;
    my $count = 0;
    while ($position > 0) {
        $position = index($s1, $s2, $position);
        $count++;
        $position++;
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("xinyyexyxx", "xx"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
