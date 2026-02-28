# 
sub f {
    my($list_x) = @_;
    my @new_list;
    my $item_count = scalar @{$list_x};
    for (my $i = 0; $i < $item_count; $i++) {
        push @new_list, pop @{$list_x};
    }
    return \@new_list;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([5, 8, 6, 8, 4]),[4, 8, 6, 8, 5])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
