# 
sub f {
    my($text, $s, $e) = @_;
    my $sublist = substr($text, $s, $e - $s);
    if ($sublist eq "") {
        return -1;
    }
    my @chars = split("", $sublist);
    my $min_char = (sort @chars)[0];
    return index($sublist, $min_char);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("happy", 0, 3),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
