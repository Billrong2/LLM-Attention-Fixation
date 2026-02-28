# 
sub f {
    my($lst) = @_;
    my @sorted = sort { $a <=> $b } @$lst;
    return [@sorted[0..2]];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, 8, 1, 3, 0]),[0, 1, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
