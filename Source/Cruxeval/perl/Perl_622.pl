# 
sub f {
    my($s) = @_;
    my ($left, $sep, $right) = reverse split /\./, $s;
    my $new = join $sep, $right, $left;
    my (undef, $sep, undef) = reverse split /\./, $new;
    $new =~ s/$sep/, /g;
    return $new;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("galgu"),", g, a, l, g, u, ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
