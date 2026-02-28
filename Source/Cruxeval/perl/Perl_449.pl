# 
sub f {
    my($x) = @_;
    my $n = length($x);
    my $i = 0;
    while ($i < $n && $x =~ /^\d+$/) {
        $i++;
    }
    return $i == $n;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("1"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
