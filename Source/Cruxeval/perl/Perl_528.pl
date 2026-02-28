# 
sub f {
    my($s) = @_;
    my $b = '';
    my $c = '';
    for my $i (split('', $s)) {
        $c = $c . $i;
        if (index($s, $c) > -1) {
            return rindex($s, $c);
        }
    }
    return 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("papeluchis"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
