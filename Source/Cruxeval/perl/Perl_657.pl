# 
sub f {
    my($text) = @_;
    for my $punct ('!', '.', '?', ',', ':', ';') {
        if ($text =~ tr/$punct// > 1) {
            return 'no';
        }
        if (substr($text, -1) eq $punct) {
            return 'no';
        }
    }
    return ucfirst($text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("djhasghasgdha"),"Djhasghasgdha")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
