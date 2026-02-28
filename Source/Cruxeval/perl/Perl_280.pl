# 
sub f {
    my($text) = @_;
    my $field = $text;
    $field =~ s/ //g;
    my $g = $text;
    $g =~ s/0/ /g;
    $text =~ s/1/i/g;

    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("00000000 00000000 01101100 01100101 01101110"),"00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
