use strict;
use warnings;
use List::Util qw(sum);

sub f {
    my ($text1, $text2) = @_;
    my @nums;
    foreach my $i (0 .. length($text2) - 1) {
        my $char = substr($text2, $i, 1);
        push @nums, scalar(grep { $_ eq $char } split //, $text1);
    }
    return sum(@nums);
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("jivespdcxc", "sx"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
