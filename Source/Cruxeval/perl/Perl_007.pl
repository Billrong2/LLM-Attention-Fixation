# 
sub f {
    my($lst) = @_;
    my @original = @{$lst};
    while(scalar @{$lst} > 1) {
        pop @{$lst};
        for(my $i = 0; $i < scalar @{$lst}; $i++) {
            splice @{$lst}, $i, 1;
        }
    }
    @{$lst} = @original;
    if(scalar @{$lst} > 0) {
        shift @{$lst};
    }
    return $lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
