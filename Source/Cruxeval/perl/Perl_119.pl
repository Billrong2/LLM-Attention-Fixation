# 
sub f {
    my($text) = @_;
    my $result = "";
    for(my $i=0; $i<length($text); $i++) {
        if($i % 2 == 0) {
            $result .= uc(substr($text, $i, 1));
        } else {
            $result .= substr($text, $i, 1);
        }
    }
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("vsnlygltaw"),"VsNlYgLtAw")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
