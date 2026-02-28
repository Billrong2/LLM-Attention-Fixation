# 
sub f {
    my($text, $chars) = @_;
    my @result = split('', $text);
    while (index(join('', @result[-3..0]), $chars) != -1) {
        splice(@result, -3, 2);
    }
    return join('', @result) =~ s/\.$//r;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ellod!p.nkyp.exa.bi.y.hain", ".n.in.ha.y"),"ellod!p.nkyp.exa.bi.y.hain")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
