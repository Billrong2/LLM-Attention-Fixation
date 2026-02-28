# 
sub f {
    my($num, $l) = @_;
    my $t = "";
    while($l > length($num)) {
        $t .= '0';
        $l -= 1;
    }
    return $t . $num;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("1", 3),"001")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
