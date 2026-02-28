# 
sub f {
    my($text) = @_;
    my @new_text;
    foreach my $character (split('', $text)) {
        if ($character =~ /[A-Z]/) {
            splice(@new_text, int(@new_text) / 2, 0, $character);
        }
    }
    if (scalar @new_text == 0) {
        @new_text = ('-');
    }
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("String matching is a big part of RexEx library."),"RES")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
