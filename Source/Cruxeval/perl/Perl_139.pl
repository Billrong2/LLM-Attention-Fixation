# 
sub f {
    my($first, $second) = @_;
    if (scalar(@$first) < 10 || scalar(@$second) < 10) {
        return 'no';
    }
    for my $i (0..4) {
        if ($first->[$i] != $second->[$i]) {
            return 'no';
        }
    }
    push @$first, @$second;
    return $first;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 1], [1, 1, 2]),"no")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
