package App::Controller::Account;
use Mojo::Base 'Mojolicious::Controller::REST';
use Mojo::Pg;


sub list_account {
    my $self = shift;
    my $result = $db->query('select * from names')->hashes->map(sub { $_->{name} })->join("\n");
    $self->data( $result )->message('You got some results from PostgreSQL!');
}

1;
