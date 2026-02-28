use strict;
use warnings;
use List::Util qw(sum);

sub f {
    my($num) = @_;

    my @initial = (1);
    my @total = @initial;
    for (1 .. $num) {
        @total = (1, map { $total[$_] + $total[$_ + 1] } 0 .. $#total - 1);
        push @initial, $total[-1];
    }
    return sum(@initial);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(3),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
