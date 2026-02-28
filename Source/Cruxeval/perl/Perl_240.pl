# 
sub f {
    my($float_number) = @_;
    my $number = $float_number;
    my $dot = index($number, '.');
    if ($dot != -1) {
        return substr($number, 0, $dot) . '.' . substr($number, $dot+1) . '0' x (2 - length(substr($number, $dot+1)));
    }
    return $number . '.00';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(3.121),"3.121")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
