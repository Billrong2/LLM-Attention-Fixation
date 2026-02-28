# 
sub f {
    my($text, $changes) = @_;
    my $result = '';
    my $count = 0;
    my @changes = split("", $changes);
    foreach my $char (split("", $text)) {
        $result .= $char if $char eq 'e';
        $result .= $changes[$count % scalar(@changes)] if $char ne 'e';
        $count += ($char ne 'e' ? 1 : 0);
    }
    return $result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("fssnvd", "yes"),"yesyes")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
