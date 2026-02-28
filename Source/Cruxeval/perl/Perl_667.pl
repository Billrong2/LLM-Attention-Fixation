# 
sub f {
    my($text) = @_;
    my @new_text;
    for(my $i = 0; $i < length($text) / 3; $i++) {
        push @new_text, "< " . substr($text, $i * 3, 3) . " level=$i >";
    }
    my $last_item = substr($text, int(length($text) / 3) * 3);
    push @new_text, "< $last_item level=" . int(length($text) / 3) . " >";
    return @new_text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("C7"),["< C7 level=0 >"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
