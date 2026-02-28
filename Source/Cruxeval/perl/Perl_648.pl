# 
sub f {
    my($list1, $list2) = @_;
    my @l = @{$list1};
    while (@l) {
        if ($l[-1] ~~ @{$list2}) {
            pop @l;
        } else {
            return $l[-1];
        }
    }
    return "missing";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 4, 5, 6], [13, 23, -5, 0]),6)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
