# 
sub f {
    my($items) = @_;
    my @items = @{$items};
    my @odd_positioned;
    while (scalar @items > 0) {
        my $position = 0;
        my $min_item = $items[0];
        for (my $i = 1; $i < scalar @items; $i++) {
            if ($items[$i] < $min_item) {
                $min_item = $items[$i];
                $position = $i;
            }
        }
        splice @items, $position, 1;
        my $item = splice @items, $position, 1;
        push @odd_positioned, $item;
    }
    return \@odd_positioned;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3, 4, 5, 6, 7, 8]),[2, 4, 6, 8])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
