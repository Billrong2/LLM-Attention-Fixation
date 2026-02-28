# 
sub f {
    my($lst) = @_;
    my $operation = sub { my @array = @{$_[0]}; @array = sort { $a <=> $b } @array; return \@array; };
    my @new_list = @{$lst};
    @new_list = sort { $a <=> $b } @new_list;
    $new_list = $operation->(\@new_list);
    return $lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([6, 4, 2, 8, 15]),[6, 4, 2, 8, 15])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
