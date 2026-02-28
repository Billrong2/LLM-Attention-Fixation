# 
sub f {
    my($graph) = @_;
    my %new_graph;
    foreach my $key (keys %{$graph}) {
        $new_graph{$key} = {};
        foreach my $subkey (keys %{$graph->{$key}}) {
            $new_graph{$key}{$subkey} = '';
        }
    }
    return \%new_graph;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
