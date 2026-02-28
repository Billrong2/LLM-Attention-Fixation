# 
sub f {
    my($s) = @_;
    if ($s =~ /^[a-zA-Z0-9]+$/) {
        return "True";
    }
    return "False";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("777"),"True")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
