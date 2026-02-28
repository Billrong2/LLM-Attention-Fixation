# 
sub f {
    my($string) = @_;
    if (index($string, 'e') != -1) {
        return rindex($string, 'e');
    } else {
        return "Nuk";
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("eeuseeeoehasa"),8)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
