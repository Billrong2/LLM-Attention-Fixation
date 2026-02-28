# 
sub f {
    my($nums, $val) = @_;
    my @new_list;
    for my $i (@$nums) {
        push @new_list, ($i) x $val;
    }
    return List::Util::sum(@new_list);
}
use List::Util qw(sum);
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([10, 4], 3),42)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
