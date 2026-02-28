# 
sub f {
    my($text) = @_;
    my @text = split(',', $text);
    shift @text;
    my $index = 0;
    foreach my $i (0..$#text) {
        if ($text[$i] eq 'T') {
            $index = $i;
            last;
        }
    }
    splice(@text, 0, 0, splice(@text, $index, 1));
    return 'T,' . join(',', @text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Dmreh,Sspp,T,G ,.tB,Vxk,Cct"),"T,T,Sspp,G ,.tB,Vxk,Cct")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
