# 
sub f {
    my($text) = @_;
    my @a = split('\n', $text);
    my @b;
    foreach my $line (@a) {
        my $c = $line;
        $c =~ s/\t/    /g;
        push @b, $c;
    }
    return join('\n', @b);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("			tab tab tabulates"),"            tab tab tabulates")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
