# 
sub f {
    my($in_list, $num) = @_;
    push @{$in_list}, $num;
    my $max_index = 0;
    my $max_value = $in_list->[0];
    for (my $i = 0; $i < @{$in_list} - 1; $i++) {
        if ($in_list->[$i] > $max_value) {
            $max_value = $in_list->[$i];
            $max_index = $i;
        }
    }
    return $max_index;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-1, 12, -6, -2], -1),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
