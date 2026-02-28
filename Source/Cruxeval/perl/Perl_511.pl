# 
sub f {
    my($fields, $update_dict) = @_;
    my %di = map { $_ => '' } @{$fields};
    foreach my $key (keys %{$update_dict}) {
        $di{$key} = $update_dict->{$key};
    }
    return \%di;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["ct", "c", "ca"], {"ca" => "cx"}),{"ct" => "", "c" => "", "ca" => "cx"})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
