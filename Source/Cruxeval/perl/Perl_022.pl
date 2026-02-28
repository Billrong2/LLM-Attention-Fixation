# 
sub f {
    my($a) = @_;
    if ($a == 0) {
        return [0];
    }
    my @result;
    while ($a > 0) {
        push @result, $a % 10;
        $a = int($a / 10);
    }
    @result = reverse @result;
    return int(join('', map {$_} @result));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(0),[0])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
