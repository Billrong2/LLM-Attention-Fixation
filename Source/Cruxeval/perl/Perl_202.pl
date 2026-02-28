# 
sub f {
    my($array, $lst) = @_;
    push(@$array, @$lst);
    my @evens = grep { $_ % 2 == 0 } @$array;
    return [grep { $_ >= 10 } @$array];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([2, 15], [15, 1]),[15, 15])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
