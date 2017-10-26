# Generated by WebService::BitbucketServer::WADL - DO NOT EDIT!
package WebService::BitbucketServer::AccessTokens::V1;
# ABSTRACT: Bindings for a Bitbucket Server REST API


use warnings;
use strict;

our $VERSION = '0.602'; # VERSION

use Moo;
use namespace::clean;


has context => (
    is          => 'ro',
    isa         => sub { die 'Not a WebService::BitbucketServer' if !$_[0]->isa('WebService::BitbucketServer'); },
    required    => 1,
);


sub _croak { require Carp; Carp::croak(@_) }

sub _get_url {
    my $url  = shift;
    my $args = shift || {};
    $url =~ s/\{([^:}]+)(?::\.\*)?\}/_get_path_parameter($1, $args)/eg;
    return $url;
}

sub _get_path_parameter {
    my $name = shift;
    my $args = shift || {};
    return delete $args->{$name} if defined $args->{$name};
    $name =~ s/([A-Z])/'_'.lc($1)/eg;
    return delete $args->{$name} if defined $args->{$name};
    _croak("Missing required parameter $name");
}


sub get_tokens {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('access-tokens/1.0/users/{userSlug}', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'GET', url => $url, $data ? (data => $data) : ());
}


sub create_token {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('access-tokens/1.0/users/{userSlug}', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'PUT', url => $url, $data ? (data => $data) : ());
}


sub delete_token {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('access-tokens/1.0/users/{userSlug}/{tokenId}', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'DELETE', url => $url, $data ? (data => $data) : ());
}


sub get_token {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('access-tokens/1.0/users/{userSlug}/{tokenId}', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'GET', url => $url, $data ? (data => $data) : ());
}


sub update_token {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('access-tokens/1.0/users/{userSlug}/{tokenId}', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'POST', url => $url, $data ? (data => $data) : ());
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

WebService::BitbucketServer::AccessTokens::V1 - Bindings for a Bitbucket Server REST API

=head1 VERSION

version 0.602

=head1 SYNOPSIS

    my $stash = WebService::BitbucketServer->new(
        base_url    => 'https://stash.example.com/',
        username    => 'bob',
        password    => 'secret',
    );
    my $api = $stash->access_tokens;

=head1 DESCRIPTION

This is a Bitbucket Server REST API for L<AccessTokens::V1|https://developer.atlassian.com/static/rest/bitbucket-server/5.5.0/bitbucket-access-tokens-rest.html>.

Original API documentation created by and copyright Atlassian.

=head1 ATTRIBUTES

=head2 context

Get the instance of L<WebService::BitbucketServer> passed to L</new>.

=head1 METHODS

=head2 new

    $api = WebService::BitbucketServer::AccessTokens::V1->new(context => $webservice_bitbucketserver_obj);

Create a new API.

Normally you would use C<<< $webservice_bitbucketserver_obj->access_tokens >>> instead.

=head2 get_tokens

Get all access tokens associated with the given user

    GET access-tokens/1.0/users/{userSlug}

Responses:

=over 4

=item * C<<< 200 >>> - accessToken, type: application/json

A response containing a page of access tokens and associated details

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user is not permitted to get access tokens on
behalf of this user or authentication failed

=item * C<<< 404 >>> - errors, type: application/json

The specified user does not exist

=back

=head2 create_token

Create an access token for the user according to the given request

    PUT access-tokens/1.0/users/{userSlug}

Responses:

=over 4

=item * C<<< 200 >>> - accessToken, type: application/json

A response containing the raw access token and associated details

=item * C<<< 400 >>> - errors, type: application/json

One of the following error cases occurred (check the error message for more details):

=over 4

=item *

The request does not contain a token name

=item *

The request does not contain a list of permissions, or the list of permissions is empty

=item *

One of the provided permission levels are unknown

=item *

The user already has their maximum number of tokens

=back

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user is not permitted to create an access token on
behalf of this user or authentication failed

=back

=head2 delete_token

Delete an access token for the user according to the given ID

    DELETE access-tokens/1.0/users/{userSlug}/{tokenId}

Parameters:

=over 4

=item * C<<< tokenId >>> - string, default: none

=back

Responses:

=over 4

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user is not permitted to delete an access token on
behalf of this user or authentication failed

=item * C<<< 204 >>> - data, type: application/json

an empty response indicating that the token has been deleted

=item * C<<< 404 >>> - errors, type: application/json

The specified user or token does not exist

=back

=head2 get_token

Get an access token for the user according to the given ID

    GET access-tokens/1.0/users/{userSlug}/{tokenId}

Parameters:

=over 4

=item * C<<< tokenId >>> - string, default: none

=back

Responses:

=over 4

=item * C<<< 200 >>> - accessToken, type: application/json

A response containing the access token and associated details

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user is not permitted to get access tokens on
behalf of this user or authentication failed

=item * C<<< 404 >>> - errors, type: application/json

The specified user or token does not exist

=back

=head2 update_token

Modify an access token for the user according to the given request. Any fields not specified
will not be altered

    POST access-tokens/1.0/users/{userSlug}/{tokenId}

Parameters:

=over 4

=item * C<<< tokenId >>> - string, default: none

=back

Responses:

=over 4

=item * C<<< 200 >>> - accessToken, type: application/json

A response containing the updated access token and associated details

=item * C<<< 400 >>> - errors, type: application/json

One of the provided permission levels are unknown

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user is not permitted to update an access token on
behalf of this user or authentication failed

=back

=head1 SEE ALSO

=over 4

=item * L<WebService::BitbucketServer>

=item * L<https://developer.atlassian.com/bitbucket/server/docs/latest/>

=back

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/chazmcgarvey/WebService-BitbucketServer/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Charles McGarvey <chazmcgarvey@brokenzipper.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Charles McGarvey.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
