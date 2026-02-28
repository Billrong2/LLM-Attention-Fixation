# 
sub f {
    my($text, $prefix) = @_;
    if (index($text, $prefix) == 0) {
        $text =~ s/^\Q$prefix\E//;
    }
    $text = ucfirst($text);
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qdhstudentamxupuihbuztn", "jdm"),"Qdhstudentamxupuihbuztn")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
