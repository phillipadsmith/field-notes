package App::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;
  return $self->redirect_to( sprintf( "/auth/%s/authenticate", 'twitter' ) );
}

sub logged_in {
    ...
}

sub logout {
    my $self = shift;
    $self->session( expires => 1 );
    $self->redirect_to('/');
}

# TODO add route for /me ? Or put it in users model?

1;
