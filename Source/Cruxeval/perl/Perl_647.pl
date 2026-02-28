# 
sub f {
    my($text, $chunks) = @_;
    my @lines = split("\n", $text);
    return \@lines;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("/alcm@ an)t//eprw)/e!/d
ujv", 0),["/alcm@ an)t//eprw)/e!/d", "ujv"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
