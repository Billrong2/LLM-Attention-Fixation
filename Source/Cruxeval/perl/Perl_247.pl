# 
sub f {
    my($s) = @_;
    if ($s =~ /^[a-zA-Z]+$/) {
        return "yes";
    }
    if ($s eq "") {
        return "str is empty";
    }
    return "no";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Boolean"),"yes")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
