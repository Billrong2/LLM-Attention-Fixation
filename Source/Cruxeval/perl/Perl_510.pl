# 
sub f {
    my($a, $b, $c, $d, $e) = @_;
    my %a = %{$a};
    my $key = $d;
    if (exists $a{$key}) {
        my $num = delete $a{$key};
    }
    if ($b > 3) {
        return join('', $c);
    } else {
        return $num;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({7 => "ii5p", 1 => "o3Jwus", 3 => "lot9L", 2 => "04g", 9 => "Wjf", 8 => "5b", 0 => "te6", 5 => "flLO", 6 => "jq", 4 => "vfa0tW"}, 4, "Wy", "Wy", 1.0),"Wy")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
