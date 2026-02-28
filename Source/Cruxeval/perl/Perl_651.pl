# 
sub f {
    my($text, $letter) = @_;
    if (lc($letter) eq $letter) {
        $letter = uc($letter);
    }
    $text =~ s/($letter)/$1 eq lc($1) ? uc($1) : $1/ge;
    $text = ucfirst($text);
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("E wrestled evil until upperfeat", "e"),"E wrestled evil until upperfeat")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
