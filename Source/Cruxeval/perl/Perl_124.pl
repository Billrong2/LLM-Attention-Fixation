# 
sub f {
    my($txt, $sep, $sep_count) = @_;
    my $o = '';
    while ($sep_count > 0 && $txt =~ /$sep/) {
        $o .= (split(/$sep/, $txt, 2))[0] . $sep;
        $txt = (split(/$sep/, $txt, 2))[1];
        $sep_count--;
    }
    return $o . $txt;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("i like you", " ", -1),"i like you")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
