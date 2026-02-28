# 
sub f {
    my($nums, $pos) = @_;
    my @s = (0 .. $#{$nums});
    if ($pos % 2) {
        @s = (0 .. $#{$nums} - 1);
    }
    @{$nums}[@s] = reverse @{$nums}[@s];
    return $nums;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6, 1], 3),[6, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
