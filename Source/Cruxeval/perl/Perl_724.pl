# 
sub f {
    my($text, $function) = @_;
    my @cites = (length(substr($text, index($text, $function) + length($function))));
    my @chars = split(//, $text);
    for my $char (@chars) {
        if ($char eq $function) {
            push(@cites, length(substr($text, index($text, $function) + length($function))));
        }
    }
    return \@cites;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("010100", "010"),[3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
