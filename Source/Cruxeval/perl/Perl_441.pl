# 
sub f {
    my($base, $k, $v) = @_;
    $base->{$k} = $v;
    return $base;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({37 => "forty-five"}, "23", "what?"),{37 => "forty-five", "23" => "what?"})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
