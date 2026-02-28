# 
sub f {
    my($values, $value) = @_;
    my @values = @{$values};
    my $length = scalar @values;
    my %new_dict;
    foreach my $v (@values) {
        $new_dict{$v} = $value;
    }
    my $sorted_values = join("", sort @values);
    $new_dict{$sorted_values} = $value * 3;
    return \%new_dict;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["0", "3"], 117),{"0" => 117, "3" => 117, "03" => 351})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
