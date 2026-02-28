# 
sub f {
    my($dictionary, $arr) = @_;
    my %dictionary = %$dictionary;
    my @arr = @$arr;
    
    $dictionary{$arr[0]} = [$arr[1]];
    if (scalar @{$dictionary{$arr[0]}} == $arr[1]) {
        $dictionary{$arr[0]} = $arr[0];
    }
    
    return \%dictionary;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}, ["a", 2]),{"a" => [2]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
