# 
sub f {
    my($s, $ch) = @_;
    if (index($s, $ch) == -1) {
        return '';
    }
    $s = substr($s, rindex($s, $ch) + 1);
    for (my $i = 0; $i < length($s); $i++) {
        $s = substr($s, rindex($s, $ch) + 1);
    }
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("shivajimonto6", "6"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
