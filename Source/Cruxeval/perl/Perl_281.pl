# 
sub f {
    my($c, $index, $value) = @_;
    $c->{$index} = $value;
    if ($value >= 3) {
        $c->{message} = 'xcrWt';
    } else {
        delete $c->{message};
    }
    return $c;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({1 => 2, 3 => 4, 5 => 6, "message" => "qrTHo"}, 8, 2),{1 => 2, 3 => 4, 5 => 6, 8 => 2})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
