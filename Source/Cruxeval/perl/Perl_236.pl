# 
sub f {
    my($array) = @_;
    my @array = @{$array};
    if (@array == 1) {
        return join('', @array);
    }
    my @result = @array;
    my $i = 0;
    while ($i < @array - 1) {
        for my $j (0..1) {
            $result[$i*2] = $array[$i];
            $i++;
        }
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["ac8", "qk6", "9wg"]),"ac8qk6qk6")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
