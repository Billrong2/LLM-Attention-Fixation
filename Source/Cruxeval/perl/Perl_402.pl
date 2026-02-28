# 
sub f {
    my($n, $l) = @_;
    my %archive;
    for my $i (0..$n-1) {
        %archive = ();
        %archive = map { $_ + 10 => $_ * 10 } @$l;
    }
    return \%archive;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(0, ["aaa", "bbb"]),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
