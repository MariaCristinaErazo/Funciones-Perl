use strict;
use warnings;
use Data::Dump qw(dump);
use numperl;
use extension;
use constant np => 'numperl';
use constant ex => 'extension';
use List::Util qw( max min );
use Chart::Plotly;
use Chart::Plotly::Trace::Scatter;
use Chart::Plotly::Trace::Scatter::Marker;

my $train_file_name = "../../Datasets/headbrain_dataset/headbrain.csv";

my ($validation, $train_data) = np->read_csv($train_file_name);
return unless $validation;

$train_data->p;

dump $train_data->shape;

my $Y_Train = np->slice($train_data, "0:238, 2:4");
$Y_Train-> p;



my $X = np->slice($Y_Train, ":,-2");
my $Y = np->slice($Y_Train, ":,-1");
$X-> p;
$Y ->p;



my $mean_x= np -> mean($X)-> {array};
my $mean_y = np ->mean($Y)-> {array};
my $m = ($X->shape)[0];
my $arr_X = $X->{array};
my $arr_Y = $Y->{array};
my $numer = 0;
my $denom = 0;
for (my $i=0; $i < $m; $i++){
    $numer += ($arr_X ->[$i] - $mean_x) * ($arr_Y->[$i]- $mean_y);
    $denom += ($arr_X->[$i]- $mean_x)**2;
}
my $b_uno = $numer / $denom;
my $b_cero= $mean_y - ($b_uno * $mean_x);


print ($b_uno,"\n",$b_cero);

my $min_x = (min @{$X->{array}}) - 100;
my $max_x = (max @{$X->{array}}) + 100;
my $x = np->linspace($min_x, $max_x,1000);
my $y = $b_cero + $b_uno * $x;



my $puntos  = Chart::Plotly::Trace::Scatter::Marker->new(color => 'blue', size => 7);
my $regression = Chart::Plotly::Trace::Scatter::Marker->new(color => 'red', size => 5);
my $dibujar_puntos = Chart::Plotly::Trace::Scatter->new(name => "Dataset", x => $x->{'array'}, y => $y->{'array'}, mode => "markers", marker => $puntos);
my $trace_regression = Chart::Plotly::Trace::Scatter->new(name => "Regresion lineal", x => $X->{'array'}, y => $Y->{'array'}, mode => "markers", marker => $regression);

IPerl->load_plugin('Chart::Plotly');
Chart::Plotly::Plot->new( traces => [$dibujar_puntos , $trace_regression], layout => { boxmode => 'group' } );

my $ss_t = 0;
my $ss_r = 0;
for(my $i=0; $i<$m; $i++){
    my $y_pred = $b_cero + $b_uno * $arr_X->[$i];
    $ss_t += ($arr_Y->[$i] - $mean_y) ** 2;
    $ss_r += ($arr_Y->[$i] - $y_pred) ** 2;
}
my $r2 = 1 - ( $ss_r / $ss_t );
print $r2;








