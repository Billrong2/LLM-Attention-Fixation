# 
sub f {
    my($s) = @_;
    my $count = length($s) - 1;
    my $reverse_s = reverse($s);
    while ($count > 0 && rindex($reverse_s, 'sea', 0) == -1) {
        $count--;
        $reverse_s = substr($reverse_s, 0, $count);
    }
    return substr($reverse_s, $count);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("s a a b s d s a a s a a"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
