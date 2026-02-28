# 
sub f {
    my($lst) = @_;
    my @res;
    foreach my $i (0..$#{$lst}) {
        if ($lst->[$i] % 2 == 0) {
            push @res, $lst->[$i];
        }
    }
    
    return [@$lst];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 4]),[1, 2, 3, 4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
