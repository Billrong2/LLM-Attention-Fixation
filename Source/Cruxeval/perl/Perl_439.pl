# 
sub f {
    my($value) = @_;
    my @parts = split(' ', $value);
    my @filtered_parts;
    foreach my $i (0 .. $#parts) {
        push @filtered_parts, $parts[$i] if $i % 2 == 0;
    }
    return join('', @filtered_parts);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("coscifysu"),"coscifysu")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
