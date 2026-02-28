# 
sub f {
    my($s, $suffix) = @_;
    if ($suffix eq "") {
        return $s;
    }
    while ($s =~ /$suffix$/) {
        $s = substr($s, 0, length($s) - length($suffix));
    }
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ababa", "ab"),"ababa")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
