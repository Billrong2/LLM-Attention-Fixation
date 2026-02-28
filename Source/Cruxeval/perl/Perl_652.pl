# 
sub f {
    my($string) = @_;
    if (!$string || !($string =~ /^\d/)) {
        return 'INVALID';
    }
    my $cur = 0;
    for my $i (0..length($string)-1) {
        $cur = $cur * 10 + int(substr($string, $i, 1));
    }
    return "$cur";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("3"),"3")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
