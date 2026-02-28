# 
sub f {
    my($text, $wrong, $right) = @_;
    my $new_text = $text;
    $new_text =~ s/$wrong/$right/g;
    return uc($new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("zn kgd jw lnt", "h", "u"),"ZN KGD JW LNT")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
