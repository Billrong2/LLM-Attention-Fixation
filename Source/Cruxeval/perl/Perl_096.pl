# 
sub f {
    my($text) = @_;
    return !grep {$_ eq uc $_} split //, $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("lunabotics"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
