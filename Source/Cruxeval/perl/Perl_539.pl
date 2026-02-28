# 
sub f {
    my($array) = @_;
    my $c = $array;
    my $array_copy = $array;

    while (1) {
        push(@$c, '_');
        if ($c eq $array_copy) {
            $array_copy->[scalar @$c-1] = '';
            last;
        }
    }
    return $array_copy;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),[""])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
