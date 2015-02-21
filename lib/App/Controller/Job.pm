package App::Controller::Job;
use Mojo::Base 'Mojolicious::Controller::REST';
use Data::Dumper;

sub list_job {
    my $self = shift;
}

sub create_job {
  my $self = shift;
  my $jid = $self->minion->enqueue('do_stuff');
  #$c->render(text => 'We will poke mojolicio.us for you soon.');
  $self->data( job_id => $jid )->message('Doing stuff!');
}

1;
