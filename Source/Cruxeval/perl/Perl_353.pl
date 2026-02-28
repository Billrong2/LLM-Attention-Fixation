# 
sub f {
    my($x) = @_;
    if (@$x == 0) {
        return -1;
    } else {
        my %cache;
        foreach my $item (@$x) {
            if (exists $cache{$item}) {
                $cache{$item}++;
            } else {
                $cache{$item} = 1;
            }
        }
        return (reverse sort values %cache)[0];
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 0, 2, 2, 0, 0, 0, 1]),4)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
