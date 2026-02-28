# 
sub f {
    my($array) = @_;
    my @newArray = @{$array};
    my $prev = $array->[0];
    
    for my $i (1 .. $#{$array}) {
        if ($prev != $array->[$i]) {
            $newArray[$i] = $array->[$i];
        } else {
            splice @newArray, $i, 1;
        }
        $prev = $array->[$i];
    }
    
    return \@newArray;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3]),[1, 2, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
