# 
sub f {
    my($array) = @_;
    @$array = reverse(@$array);
    @$array = ();
    push @$array, ('x') x scalar(@$array);
    @$array = reverse(@$array);
    return $array;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, -2, 0]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
