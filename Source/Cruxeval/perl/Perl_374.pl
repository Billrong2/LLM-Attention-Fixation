# 
sub f {
    my($seq, $v) = @_;
    my @a;
    foreach my $i (@$seq) {
        if ($i =~ /$v$/) {
            push @a, $i x 2;
        }
    }
    return \@a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["oH", "ee", "mb", "deft", "n", "zz", "f", "abA"], "zz"),["zzzz"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
