# 
sub f {
    my($text) = @_;
    my $result = '';
    my $i = length($text) - 1;
    while ($i >= 0) {
        my $c = substr($text, $i, 1);
        if ($c =~ /[a-zA-Z]/) {
            $result .= $c;
        }
        $i--;
    }
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("102x0zoq"),"qozx")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
