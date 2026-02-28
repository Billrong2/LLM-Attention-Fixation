# 
sub f {
    my($nums) = @_;
    my $middle = int(@{$nums} / 2);
    return [@{$nums}[$middle..$#{$nums}], @{$nums}[0..$middle-1]];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1, 1]),[1, 1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
