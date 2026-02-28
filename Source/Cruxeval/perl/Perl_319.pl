# 
sub f {
    my($needle, $haystack) = @_;
    my $count = 0;
    while (index($haystack, $needle) != -1) {
        $haystack =~ s/\Q$needle\E//;
        $count++;
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a", "xxxaaxaaxx"),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
