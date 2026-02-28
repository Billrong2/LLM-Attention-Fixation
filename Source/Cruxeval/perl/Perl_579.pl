# 
sub f {
    my($text) = @_;
    if ($text =~ /^[A-Z][a-z]*$/) {
        if (length($text) > 1 && lc($text) ne $text) {
            return lc(substr($text, 0, 1)) . substr($text, 1);
        }
    } elsif ($text =~ /^[a-zA-Z]+$/) {
        return ucfirst(lc($text));
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(""),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
