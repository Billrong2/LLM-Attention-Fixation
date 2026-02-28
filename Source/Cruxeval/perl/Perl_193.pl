# 
sub f {
    my($string) = @_;
    my $count = () = $string =~ /:/g;
    return substr($string, 0, rindex($string, ':')) . substr($string, rindex($string, ':')+1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("1::1"),"1:1")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
