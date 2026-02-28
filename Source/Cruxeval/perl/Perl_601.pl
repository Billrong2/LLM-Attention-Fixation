# 
sub f {
    my($text) = @_;
    my $t = 5;
    my @tab;
    foreach my $i (split(//, $text)) {
        if (lc $i eq 'a' || lc $i eq 'e' || lc $i eq 'i' || lc $i eq 'o' || lc $i eq 'u' || lc $i eq 'y') {
            push @tab, uc($i) x $t;
        } else {
            push @tab, $i x $t;
        }
    }
    return join(' ', @tab);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("csharp"),"ccccc sssss hhhhh AAAAA rrrrr ppppp")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
