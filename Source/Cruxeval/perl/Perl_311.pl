# 
sub f {
    my($text) = @_;
    $text =~ s/#/1/g;
    $text =~ s/\$/5/g;
    
    return $text =~ /^\d+$/ ? 'yes' : 'no';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("A"),"no")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
