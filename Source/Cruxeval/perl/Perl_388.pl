# 
sub f {
    my($text, $characters) = @_;
    my @character_list = split(//, $characters);
    push @character_list, ' ';
    push @character_list, '_';

    my $i = 0;
    while ($i < length($text) and index(@character_list, substr($text, $i, 1)) != -1) {
        $i += 1;
    }

    return substr($text, $i);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("2nm_28in", "nm"),"2nm_28in")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
