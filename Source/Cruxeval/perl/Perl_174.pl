sub f {
    my($lst) = @_;
    my @new_lst = @{$lst}[0, 2, 1];
    return \@new_lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3]),[1, 3, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
