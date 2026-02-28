# 
sub f {
    my($items) = @_;
    my @result;
    foreach my $item (@$items) {
        foreach my $d (split('', $item)) {
            if ($d !~ /^\d$/) {
                push @result, $d;
            }
        }
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["123", "cat", "d dee"]),["c", "a", "t", "d", " ", "d", "e", "e"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
