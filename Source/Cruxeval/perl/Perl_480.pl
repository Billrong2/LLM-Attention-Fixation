# 
sub f {
    my($s, $c1, $c2) = @_;
    if ($s eq '') {
        return $s;
    }
    my @ls = split(/$c1/, $s);
    foreach my $index (0 .. $#ls) {
        if (index($ls[$index], $c1) != -1) {
            $ls[$index] =~ s/$c1/$c2/;
        }
    }
    return join($c1, @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("", "mi", "siast"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
