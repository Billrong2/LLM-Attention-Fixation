# 
sub f {
    my($s1, $s2) = @_;
    my @res;
    my $i = rindex($s1, $s2);
    while ($i != -1) {
        push @res, $i + length($s2) - 1;
        $i = rindex($s1, $s2, $i - length($s2));
    }
    return \@res;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abcdefghabc", "abc"),[10, 2])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
