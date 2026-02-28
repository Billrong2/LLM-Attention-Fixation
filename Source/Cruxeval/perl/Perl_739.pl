use strict;
use warnings;

sub f {
    my($st, $pattern) = @_;
    for my $p (@$pattern) {
        return "" unless $st =~ /^$p/;
        $st = substr($st, length($p));
    }
    return 1;
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qwbnjrxs", ["jr", "b", "r", "qw"]),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
