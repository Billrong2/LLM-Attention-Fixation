# 
sub f {
    my($sequence, $value) = @_;
    my $i = index($sequence, $value) - int(length($sequence) / 3);
    $i = $i >= 0 ? $i : 0;
    my $result = '';
    for my $j (0 .. length($sequence) - $i - 1) {
        my $v = substr($sequence, $i + $j, 1);
        if ($v eq '+') {
            $result .= $value;
        } else {
            $result .= substr($sequence, $i + $j, 1);
        }
    }
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hosu", "o"),"hosu")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
