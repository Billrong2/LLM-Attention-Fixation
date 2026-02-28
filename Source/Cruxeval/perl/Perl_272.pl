# 
sub f {
    my($base_list, $nums) = @_;
    push @$base_list, @$nums;
    my @res = @$base_list;
    for my $i (-scalar(@$nums)..-1) {
        push @res, $res[$i];
    }
    return \@res;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([9, 7, 5, 3, 1], [2, 4, 6, 8, 0]),[9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
