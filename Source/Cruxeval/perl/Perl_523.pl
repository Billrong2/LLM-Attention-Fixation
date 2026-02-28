# 
sub f {
    my($text) = @_;
    my @text = split(//, $text);
    for (my $i = $#text; $i >= 0; $i--) {
        if ($text[$i] =~ /\s/) {
            $text[$i] = '&nbsp;';
        }
    }
    return join('', @text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("   "),"&nbsp;&nbsp;&nbsp;")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
