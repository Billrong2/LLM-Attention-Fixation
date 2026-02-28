use strict;
use warnings;

sub f {
    my($number) = @_;
    return $number =~ /^\d+$/ ? 1 : "";
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dummy33;d"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
