# 
sub f {
    my($total, $arg) = @_;
    if (ref $arg eq 'ARRAY') {
        foreach my $e (@$arg) {
            push @$total, split //, $e;
        }
    } else {
        push @$total, split //, $arg;
    }
    return $total;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["1", "2", "3"], "nammo"),["1", "2", "3", "n", "a", "m", "m", "o"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
