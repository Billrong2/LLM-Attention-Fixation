# 
sub f {
    my($string) = @_;
    while ($string) {
        if (substr($string, -1) =~ /[a-zA-Z]/) {
            return $string;
        }
        $string = substr($string, 0, -1);
    }
    return $string;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("--4/0-209"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
