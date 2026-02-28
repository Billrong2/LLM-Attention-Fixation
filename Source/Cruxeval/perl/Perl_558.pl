use strict;
use warnings;

sub f {
    my ($nums, $mos) = @_;
    foreach my $num (@$mos) {
        my $index = 0;
        foreach my $n (@$nums) {
            last if $n == $num;
            $index++;
        }
        splice(@$nums, $index, 1);
    }
    @$nums = sort { $a <=> $b } @$nums;
    push(@$nums, @$mos);
    for (my $i = 0; $i < @$nums - 1; $i++) {
        if ($nums->[$i] > $nums->[$i + 1]) {
            return "";
        }
    }
    return 1;
}


use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 1, 2, 1, 4, 1], [1]),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
