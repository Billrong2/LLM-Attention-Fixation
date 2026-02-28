# 
sub f {
    my($arr) = @_;
    my @sub = @{$arr};
    my $count = scalar @sub;
    for(my $i = 0; $i < $count; $i += 2) {
        $sub[$i] *= 5;
    }
    return \@sub;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-3, -6, 2, 7]),[-15, -6, 10, 7])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
