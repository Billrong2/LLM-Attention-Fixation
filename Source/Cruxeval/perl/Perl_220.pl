# 
sub f {
    my($text, $m, $n) = @_;
    my $text = $text . substr($text, 0, $m) . substr($text, $n);
    my $result = "";
    for (my $i = $n; $i < length($text)-$m; $i++) {
        $result = substr($text, $i, 1) . $result;
    }
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abcdefgabc", 1, 2),"bagfedcacbagfedc")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
