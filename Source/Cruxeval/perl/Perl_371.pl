# 
sub f {
    my($nums) = @_;
    my @nums = @{$nums};
    
    for (my $i = 0; $i < scalar @nums; $i++) {
        my $odd = $nums[$i];
        if ($odd % 2 != 0) {
            splice @nums, $i, 1;
            $i--; # Adjust index after removing element
        }
    }
    
    my $sum = 0;
    foreach my $num (@nums) {
        $sum += $num;
    }
    
    return $sum;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([11, 21, 0, 11]),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
