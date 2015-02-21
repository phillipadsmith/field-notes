package App;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;
use Data::Dumper;

  
# This method will run once at server start
sub startup {
    my $self = shift;
    # Helpers
    # TODO grab this from app.development.json
    $self->helper( pg => sub { state $pg = Mojo::Pg->new('postgresql://phillipadsmith:@localhost/mojo_pg_test') } );
    ########################################
    # Plugins
    ########################################
    # Documentation browser under "/perldoc"
    $self->plugin( 'PODRenderer' );

    # Configuration 

    # Log output to the browser console
    $self->plugin( 'ConsoleLogger' );

    # OAuth1 & OAuth2
    # TODO grab this from app.development.json
    $self->plugin(
        'Web::Auth',
        module => 'Twitter',
        key => 'ZoqMuG1WnIB7WnT6OVgduKRmC',
        secret      => 'B7q7dMk9eutFq3ZH5ZKxB9Xq2gAYrmB5mFhjvuBf2t1z91uKnw',
        on_finished => sub {
            my ( $c, $access_token, $access_secret, $account_info ) = @_;
            $c->session( 'access_token'  => $access_token );
            $c->session( 'access_secret' => $access_secret );
            $c->session( 'account_info' =>
                    { screen_name => $account_info->{screen_name} } );
            return $c->redirect_to( '/' );
        }
    );
    $self->plugin( 'REST' => { prefix => 'api', version => 'v1' } );
    #$self->plugin( 'Minion' => { Pg => 'postgresql://phillipadsmith:@localhost/canvas_minion' } );
    # TODO grab this from app.development.json
    $self->plugin( 'Minion' => { File => '/Users/phillipadsmith/Development/canvas.aljazeera.com/app/minion.db' } );

    ########################################
    # Tasks
    ########################################
    $self->minion->add_task(do_stuff => sub {
      my $job = shift;
      # Do some work
      $job->app->log->debug('We are running the job...');
      $job->finish({ status => "success", msg => "Doing stuff"});
    say "Job done!"; 
    });
   
    ## Create a table
    #my $pg = $self->pg;
    #$pg->db->do('create table if not exists names (name varchar(255))');

    ### Insert a few rows
    #my $db = $pg->db;
    #$db->query('insert into names values (?)', 'Sara');
    #$db->query('insert into names values (?)', 'Daniel');



    ########################################
    # Router
    ########################################
    my $r = $self->routes;

    # Normal routes to controllers
    $r->get( '/' )->to( 'default#welcome' );
    # To OAuth against Twitter
    $r->get( '/login' )->to( 'login#index' );
    $r->get( '/logout' )->to( 'login#logout' );

    # Automatic REST routes provided by
    # Mojolicious::Plugin::REST
    #
    # Simple API for accounts in PostgreSQL
    $r->rest_routes( name => 'Account' );
    # Work w/ jobs in the Minion job queue
    $r->rest_routes( name => 'Job' );
    # Work w/ documents in the Elastic Search database
    $r->rest_routes( name => 'Document' );
}

1;
