# 
sub f {
    my($txt, $marker) = @_;
    my @a;
    my @lines = split(/\n/, $txt);
    for my $line (@lines) {
        push(@a, sprintf("%*s", int(($marker + length($line))/2), $line));
    }
    return join("\n", @a);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("#[)[]>[^e>
 8", -5),"#[)[]>[^e>
 8")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
