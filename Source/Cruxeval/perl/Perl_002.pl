# 
sub f {
    my($text) = @_;
    my @new_text = split(//, $text);
    for my $i ('+') {
        if ($i ~~ @new_text) {
            @new_text = grep { $_ ne $i } @new_text;
        }
    }
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hbtofdeiequ"),"hbtofdeiequ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
