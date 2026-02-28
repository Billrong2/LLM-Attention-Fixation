# 
sub f {
    my($text) = @_;
    my @new_text = map { $_ =~ /\d/ ? $_ : '*' } split('', $text);
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("5f83u23saa"),"5*83*23***")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
