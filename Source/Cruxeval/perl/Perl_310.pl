# 
sub f {
    my($strands) = @_;
    my @subs = @$strands;
    for my $i (0..$#subs) {
        my @chars = split('', $subs[$i]);
        for (1..int(@chars/2)) {
            $subs[$i] = $chars[-1] . join('', @chars[1..$#chars-1]) . $chars[0];
        }
    }
    return join('', @subs);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["__", "1", ".", "0", "r0", "__", "a_j", "6", "__", "6"]),"__1.00r__j_a6__6")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
