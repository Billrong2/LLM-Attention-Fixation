# 
sub f {
    my($lst) = @_;
    my $i = 0;
    my @new_list;
    while ($i < scalar(@$lst)) {
        if ($lst->[$i] ~~ @{$lst}[($i+1)..$#$lst]) {
            push @new_list, $lst->[$i];
            if (scalar(@new_list) == 3) {
                return \@new_list;
            }
        }
        $i++;
    }
    return \@new_list;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([0, 2, 1, 2, 6, 2, 6, 3, 0]),[0, 2, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
