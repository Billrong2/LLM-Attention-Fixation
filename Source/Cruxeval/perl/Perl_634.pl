# 
sub f {
    my($input_string) = @_;
    my $table = {'a' => 'i', 'i' => 'o', 'o' => 'u', 'e' => 'a'};
    while ($input_string =~ /a|A/) {
        $input_string =~ tr/aioe/ioua/;
    }
    return $input_string;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("biec"),"biec")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
