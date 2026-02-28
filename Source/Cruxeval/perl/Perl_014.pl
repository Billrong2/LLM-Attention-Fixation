# 
sub f {
    my($s) = @_;
    my @arr = reverse(split //, $s =~ s/^\s+|\s+$//gr);
    return join('', @arr);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("   OOP   "),"POO")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
