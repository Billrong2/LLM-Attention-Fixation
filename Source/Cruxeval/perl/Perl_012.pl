# 
sub f {
    my($s, $x) = @_;
    my $count = 0;
    while (substr($s, 0, length($x)) eq $x && $count < length($s) - length($x)) {
        $s = substr($s, length($x));
        $count += length($x);
    }
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("If you want to live a happy life! Daniel", "Daniel"),"If you want to live a happy life! Daniel")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
