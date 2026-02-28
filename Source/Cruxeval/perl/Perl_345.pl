use strict;
use warnings;

sub f {
    my ($a, $b) = @_;
    if ($a lt $b) {
        return [$b, $a];
    }
    return [$a, $b];
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ml", "mv"),["mv", "ml"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
