# 
sub f {
    my($dict0) = @_;
    my %new = %$dict0;
    my @sorted_keys = sort { $a <=> $b } keys %new;
    for (my $i = 0; $i < scalar @sorted_keys - 1; $i++) {
        $dict0->{$sorted_keys[$i]} = $i;
    }
    return $dict0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({2 => 5, 4 => 1, 3 => 5, 1 => 3, 5 => 1}),{2 => 1, 4 => 3, 3 => 2, 1 => 0, 5 => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
