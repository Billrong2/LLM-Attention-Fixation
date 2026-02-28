# 
sub f {
    my($text, $old, $new) = @_;
    if (length($old) > 3) {
        return $text;
    }
    if (index($text, $old) != -1 && index($text, ' ') == -1) {
        return $text =~ s/\Q$old/$new x length($old)/reg;
    }
    while (index($text, $old) != -1) {
        $text =~ s/\Q$old/$new/g;
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("avacado", "va", "-"),"a--cado")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
