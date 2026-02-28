# 
sub f {
    my($text) = @_;
    my $out = "";
    for my $i (0..length($text)-1) {
        if (uc(substr($text, $i, 1)) eq substr($text, $i, 1)) {
            $out .= lc substr($text, $i, 1);
        } else {
            $out .= uc substr($text, $i, 1);
        }
    }
    return $out;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(",wPzPppdl/"),",WpZpPPDL/")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
