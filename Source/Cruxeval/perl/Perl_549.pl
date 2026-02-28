# 
sub f {
    my($matrix) = @_;
    my $result = [];
    @$matrix = reverse @$matrix;
    for my $primary (@$matrix) {
        my $max = max(@$primary);
        @$primary = sort {$b <=> $a} @$primary;
        push @$result, $primary;
    }
    return $result;
}
use List::Util qw(max);
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([[1, 1, 1, 1]]),[[1, 1, 1, 1]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
