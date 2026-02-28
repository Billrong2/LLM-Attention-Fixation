use strict;
use warnings;

sub f {
    my($t) = @_;
    foreach my $c (split //, $t) {
        if ($c !~ /^\d+$/) {
            return "";
        }
    }
    return 1;
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("#284376598"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
