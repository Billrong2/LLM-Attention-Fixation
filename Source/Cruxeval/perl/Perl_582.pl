# 
sub f {
    my($k, $j) = @_;
    my @arr;
    for (my $i = 0; $i < $k; $i++) {
        push @arr, $j;
    }
    return \@arr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(7, 5),[5, 5, 5, 5, 5, 5, 5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
