# 
sub f {
    my($text, $char) = @_;
    if (index($text, $char) != -1) {
        my ($suff, $pref) = split(/$char/, $text, 2);
        $pref = $suff . substr($suff, length($char)) . $char . $pref;
        return $suff . $char . $pref;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("uzlwaqiaj", "u"),"uuzlwaqiaj")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
