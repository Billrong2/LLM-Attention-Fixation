# 
sub f {
    my($text, $elem) = @_;
    if ($elem ne '') {
        while ($text =~ /^$elem/) {
            $text =~ s/$elem//g;
        }
        while ($elem =~ /^$text/) {
            $elem =~ s/$text//g;
        }
    }
    return [$elem, $text];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("some", "1"),["1", "some"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
