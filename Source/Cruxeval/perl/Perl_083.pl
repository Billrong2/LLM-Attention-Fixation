# 
sub f {
    my($text) = @_;
    my @l = split /0/, $text, -1;
    if ($l[-1] eq '') {
        return "-1:-1";
    }
    return length($l[0]) . ":" . (index($l[-1], "0") + 1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qq0tt"),"2:0")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
