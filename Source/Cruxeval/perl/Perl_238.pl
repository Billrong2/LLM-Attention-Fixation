# 
sub f {
    my($ls, $n) = @_;
    my $answer = 0;
    foreach my $i (@{$ls}) {
        if ($i->[0] == $n) {
            $answer = $i;
        }
    }
    return $answer;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[1, 9, 4], [83, 0, 5], [9, 6, 100]], 1),[1, 9, 4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
