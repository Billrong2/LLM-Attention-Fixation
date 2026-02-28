# 
sub f {
    my($a, $b, $n) = @_;
    my ($result, $m) = ($b, $b);
    for (my $i = 0; $i < $n; $i++) {
        if ($m) {
            ($a, $m) = ($a =~ s/\Q$m\E//r, undef);
            ($result, $m) = ($b, $b);
        }
    }
    return (join $result, split /$b/, $a);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("unrndqafi", "c", 2),"unrndqafi")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
