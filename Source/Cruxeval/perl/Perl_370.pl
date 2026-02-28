use strict;
use warnings;

sub f {
    my($text) = @_;
    my @text = split //, $text;
    foreach my $char (@text) {
        if ($char !~ /\s/) {
            return "";
        }
    }
    return 1;
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("     i"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
