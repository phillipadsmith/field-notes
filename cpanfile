# Basic stack
# Web framework
# DB migrations
# DB driver
# Job queue
requires 'Mojolicious', '5.61';
requires 'Mojolicious::Command::deploy::heroku', '';
requires 'App::Sqitch', '0.997';
#requires 'DBD::Pg', '3.4.2';
requires 'Mojolicious::Plugin::Minion', '0';
#requires 'Minion::Backend::Pg', '0';
requires 'Minion::Backend::File', '0';
#requires 'Mojo::Pg', '0';
requires 'DBM::Deep', '0';

# Log Mojolicious info to the console (patched to work with JSON responses)
requires 'Mojolicious::Plugin::ConsoleLogger', '0';

# OAuth
requires 'IO::Socket::SSL', '0';
requires 'Mojolicious::Plugin::Web::Auth', '0';
requires 'LWP::Protocol::https', '0';

# RESTful routes
requires 'Mojolicious::Plugin::REST', '0.006';
requires 'Mojolicious::Controller::REST', '0.006';

requires 'Mojolicious::Plugin::JSONP', '0';
