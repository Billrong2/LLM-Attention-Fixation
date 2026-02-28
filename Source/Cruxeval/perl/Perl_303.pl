# 
sub f {
    my($text) = @_;
    my $i = (length($text) + 1) / 2;
    my @result = split('', $text);
    while ($i < length($text)) {
        my $t = lc($result[$i]);
        if ($t eq $result[$i]) {
            $i++;
        } else {
            $result[$i] = $t;
        }
        $i += 2;
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mJkLbn"),"mJklbn")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
