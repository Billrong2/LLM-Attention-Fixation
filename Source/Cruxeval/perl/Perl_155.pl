# 
sub f {
    my($ip, $n) = @_;
    my $i = 0;
    my $out = '';
    foreach my $c (split('', $ip)) {
        if ($i == $n) {
            $out .= "\n";
            $i = 0;
        }
        $i++;
        $out .= $c;
    }
    return $out;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dskjs hjcdjnxhjicnn", 4),"dskj
s hj
cdjn
xhji
cnn")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
