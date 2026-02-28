# 
sub f {
    my($text, $chars) = @_;
    my @chars = split(//, $chars);
    my @text = split(//, $text);
    my @new_text = @text;
    while (scalar(@new_text) > 0 && @text) {
        if (grep {$_ eq $new_text[0]} @chars) {
            shift @new_text;
        } else {
            last;
        }
    }
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("asfdellos", "Ta"),"sfdellos")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
