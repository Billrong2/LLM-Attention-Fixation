# 
sub f {
    my($text) = @_;
    my @ls = split / /, $text;
    my @lines = split / /, join(" ", @ls[grep { $_ % 3 == 0 } 0..$#ls]);
    my @res;
    for my $i (0..1) {
        my @ln = @ls[grep { $_ % 3 == 1 } 0..$#ls];
        if (3 * $i + 1 < @ln) {
            push @res, join(" ", @ln[3 * $i..3 * ($i + 1) - 1]);
        }
    }
    return [@lines, @res];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("echo hello!!! nice!"),["echo"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
