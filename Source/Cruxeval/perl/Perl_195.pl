# 
sub f {
    my($text) = @_;
    my @p = ('acs', 'asp', 'scn');
    foreach my $p (@p) {
        $text =~ s/^$p//;
        $text = $text . ' ';
    }
    $text =~ s/^ //;
    $text = substr($text, 0, -1);
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ilfdoirwirmtoibsac"),"ilfdoirwirmtoibsac  ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
