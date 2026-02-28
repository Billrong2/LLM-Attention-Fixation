# 
sub f {
    my($text, $prefix) = @_;
    if (index($text, $prefix) == 0) {
        return substr($text, length($prefix));
    }
    if (index($text, $prefix) != -1) {
        $text =~ s/$prefix//g;
        $text =~ s/^\s+|\s+$//g;
        return $text;
    }
    return uc($text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abixaaaily", "al"),"ABIXAAAILY")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
