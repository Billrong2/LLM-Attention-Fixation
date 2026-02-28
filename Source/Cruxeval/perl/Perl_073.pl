# 
sub f {
    my($row) = @_;
    $row =~ s/[01]//g;
    my $count_1 = length($row);
    $row =~ s/[01]//g;
    my $count_0 = length($row);
    return ($count_1, $count_0);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("100010010"),[3, 6])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
