# 
sub f {
    my($text, $ch) = @_;
    my @result;
    my @lines = split(/\n/, $text);
    foreach my $line (@lines) {
        if (length($line) > 0 && substr($line, 0, 1) eq $ch) {
            push @result, lc($line);
        } else {
            push @result, uc($line);
        }
    }
    return join("\n", @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("t
za
a", "t"),"t
ZA
A")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
