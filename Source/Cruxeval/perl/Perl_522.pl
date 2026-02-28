# 
sub f {
    my($numbers) = @_;
    my @floats = map { $_ % 1 } @$numbers;
    return @floats ? @floats : ();
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
