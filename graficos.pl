use warnings;
use strict;
use GD::Graph::points;

my @data = ( 
  ["1st","2nd","3rd","4th","5th","6th","7th", "8th", "9th"],
  [    1,    2,    5,    6,    3,  1.5,    1,     3,     4],
  [ sort { $a <=> $b } (1, 2, 5, 6, 3, 1.5, 1, 3, 4) ]
);


my $graph = new GD::Graph::points(900, 300);
#my $graph = GD::Graph::mixed->new(400, 300);

$graph->set( 
    x_label           => 'X Label',
    y_label           => 'Y label',
    title             => 'Some simple graph',
    y_max_value       => 8,
    y_tick_number     => 8,
    y_label_skip      => 2 
) or die $graph->error;
my $gd = $graph->plot(\@data) or die $graph->error;
open(IMG, '>file1.png') or die $!;
binmode IMG;
print IMG $gd->png;

print IMG $graph->plot(\@data)->gif;