# 
sub f {
    my($temp, $timeLimit) = @_;
    my $s = int($timeLimit / $temp);
    my $e = $timeLimit % $temp;
    return $e . " oC" if $s <= 1;
    return "$s $e";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(1, 1234567890),"1234567890 0")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
