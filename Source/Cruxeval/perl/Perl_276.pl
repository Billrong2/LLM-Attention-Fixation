# 
sub f {
    my($a) = @_;
    if (scalar(@$a) >= 2 && $a->[0] > 0 && $a->[1] > 0) {
        @$a = reverse(@$a);
        return $a;
    }
    push @$a, 0;
    return $a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[0])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
