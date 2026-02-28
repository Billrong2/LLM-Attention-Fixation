sub f {
    my($a, $split_on) = @_;
    my @t = split(' ', $a);
    my @a = ();
    for my $i (@t) {
        for my $j (split //, $i) {
            push @a, $j;
        }
    }
    if (grep($_ eq $split_on, @a)) {
        return 1;
    } else {
        return "";
    }
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("booty boot-boot bootclass", "k"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
