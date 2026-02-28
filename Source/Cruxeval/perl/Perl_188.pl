# 
sub f {
    my($strings) = @_;
    my @new_strings;
    foreach my $string (@$strings) {
        my $first_two = substr($string, 0, 2);
        if ($first_two =~ /^[ap]/){
            push(@new_strings, $first_two);
        }
    }
    return \@new_strings;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["a", "b", "car", "d"]),["a"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
