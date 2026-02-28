# 
sub f {
    my($text, $old, $new) = @_;
    my $text2 = $text;
    $text2 =~ s/$old/$new/g;
    my $old2 = reverse $old;
    while (index($text2, $old2) != -1) {
        $text2 =~ s/$old2/$new/g;
    }
    return $text2;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("some test string", "some", "any"),"any test string")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
