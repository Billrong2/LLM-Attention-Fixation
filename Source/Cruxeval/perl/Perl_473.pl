# 
sub f {
    my($text, $value) = @_;
    my @indexes;
    for(my $i = 0; $i < length($text); $i++) {
        if(substr($text, $i, 1) eq $value) {
            push @indexes, $i;
        }
    }
    my @new_text = split('', $text);
    foreach my $i (@indexes) {
        splice @new_text, $i, 1, '';
    }
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("scedvtvotkwqfoqn", "o"),"scedvtvtkwqfqn")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
