# 
sub f {
    my($text, $tab_size) = @_;
    $text =~ s/\t/ /g while $text =~ /\t/;
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a", 100),"a")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
