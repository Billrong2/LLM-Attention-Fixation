# 
sub f {
    my($lists) = @_;
    $lists->[1] = [];
    push @{$lists->[2]}, @{$lists->[1]};
    return $lists->[0];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[395, 666, 7, 4], [], [4223, 111]]),[395, 666, 7, 4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
