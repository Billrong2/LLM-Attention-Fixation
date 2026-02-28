# 
sub f {
    my($text, $froms) = @_;
    return $text =~ s/^[$froms]+|[$froms]+$//rg;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("0 t 1cos ", "st 0	
  "),"1co")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
