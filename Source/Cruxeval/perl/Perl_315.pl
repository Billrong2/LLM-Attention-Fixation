# 
sub f {
    my($challenge) = @_;
    my $result = lc($challenge);
    $result =~ s/l/,/g;
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("czywZ"),"czywz")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
