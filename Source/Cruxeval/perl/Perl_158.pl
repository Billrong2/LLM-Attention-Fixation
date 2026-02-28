# 
sub f {
    my($arr) = @_;
    my @n = grep { $_ % 2 == 0 } @$arr;
    my @m = (@n, @$arr);
    @m = grep { my $i = $_; scalar(grep { $_ == $i } @n) } @m;
    return \@m;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([3, 6, 4, -2, 5]),[6, 4, -2, 6, 4, -2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
