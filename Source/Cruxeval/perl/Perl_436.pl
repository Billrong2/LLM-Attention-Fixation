# 
sub f {
    my($s, $characters) = @_;
    my @result;
    for my $i (@$characters) {
        push @result, substr($s, $i, 1);
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("s7 6s 1ss", [1, 3, 6, 1, 2]),["7", "6", "1", "7", " "])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
