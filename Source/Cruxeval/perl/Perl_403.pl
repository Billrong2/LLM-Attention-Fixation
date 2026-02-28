# 
sub f {
    my($full, $part) = @_;
    my $length = length($part);
    my $index = index($full, $part);
    my $count = 0;
    while ($index >= 0) {
        $full = substr($full, $index + $length);
        $index = index($full, $part);
        $count++;
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hrsiajiajieihruejfhbrisvlmmy", "hr"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
