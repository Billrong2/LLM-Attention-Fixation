# 
sub f {
    my($d, $count) = @_;
    my %new_dict;
    for (my $i = 0; $i < $count; $i++) {
        my %copy = %$d;
        %new_dict = (%copy, %new_dict);
    }
    return \%new_dict;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"a" => 2, "b" => [], "c" => {}}, 0),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
