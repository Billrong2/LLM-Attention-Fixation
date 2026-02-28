# 
sub f {
    my($no) = @_;
    my %d;
    foreach my $item (@$no) {
        $d{$item} = 0;
    }
    return scalar keys %d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["l", "f", "h", "g", "s", "b"]),6)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
