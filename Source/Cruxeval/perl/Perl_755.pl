# 
sub f {
    my($replace, $text, $hide) = @_;
    while (index($text, $hide) != -1) {
        $replace .= 'ax';
        $text =~ s/\Q$hide/$replace/e;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("###", "ph>t#A#BiEcDefW#ON#iiNCU", "."),"ph>t#A#BiEcDefW#ON#iiNCU")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
