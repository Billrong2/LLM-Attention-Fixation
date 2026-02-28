# 
sub f {
    my($text) = @_;
    $text =~ s/ x/ x./g;
    if (ucfirst $text eq $text) { return 'correct' }
    $text =~ s/ x./ x/g;
    return 'mixed';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("398 Is A Poor Year To Sow"),"correct")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
