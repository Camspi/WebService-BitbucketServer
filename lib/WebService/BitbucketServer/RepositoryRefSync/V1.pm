# Generated by WebService::BitbucketServer::WADL - DO NOT EDIT!
package WebService::BitbucketServer::RepositoryRefSync::V1;
# ABSTRACT: Bindings for a Bitbucket Server REST API


use warnings;
use strict;

our $VERSION = '0.601'; # VERSION

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


sub set_enabled {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('sync/1.0/projects/{projectKey}/repos/{repositorySlug}', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'POST', url => $url, $data ? (data => $data) : ());
}


sub get_status {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('sync/1.0/projects/{projectKey}/repos/{repositorySlug}', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'GET', url => $url, $data ? (data => $data) : ());
}


sub synchronize {
    my $self = shift;
    my $args = {@_ == 1 ? %{$_[0]} : @_};
    my $url  = _get_url('sync/1.0/projects/{projectKey}/repos/{repositorySlug}/synchronize', $args);
    my $data = (exists $args->{data} && $args->{data}) || (%$args && $args);
    $self->context->call(method => 'POST', url => $url, $data ? (data => $data) : ());
}


1;

__END__

=pod

=encoding UTF-8

=head1 NAME

WebService::BitbucketServer::RepositoryRefSync::V1 - Bindings for a Bitbucket Server REST API

=head1 VERSION

version 0.601

=head1 SYNOPSIS

    my $stash = WebService::BitbucketServer->new(
        base_url    => 'https://stash.example.com/',
        username    => 'bob',
        password    => 'secret',
    );
    my $api = $stash->repository_ref_sync;

=head1 DESCRIPTION

This is a Bitbucket Server REST API for L<RepositoryRefSync::V1|https://developer.atlassian.com/static/rest/bitbucket-server/5.5.0/bitbucket-repository-ref-sync-rest.html>.

Original API documentation created by and copyright Atlassian.

=head1 ATTRIBUTES

=head2 context

Get the instance of L<WebService::BitbucketServer> passed to L</new>.

=head1 METHODS

=head2 new

    $api = WebService::BitbucketServer::RepositoryRefSync::V1->new(context => $webservice_bitbucketserver_obj);

Create a new API.

Normally you would use C<<< $webservice_bitbucketserver_obj->repository_ref_sync >>> instead.

=head2 set_enabled

Enables or disables synchronization for the specified repository. When synchronization is enabled, branches
within the repository are immediately synchronized and the status is updated with the outcome. That initial
synchronization is performed before the REST request returns, allowing it to return the updated status.

The authenticated user must have B<<< REPO_ADMIN >>> permission for the specified repository. Anonymous users
cannot manage synchronization, even on public repositories. Additionally, synchronization must be available
for the specified repository. Synchronization is only available if:

=over 4

=item *

The repository is a fork, since its origin is used as upstream

=item *

The owning user still has access to the fork's origin, if the repository is a I<<< personal fork >>>

=back

    POST sync/1.0/projects/{projectKey}/repos/{repositorySlug}

Responses:

=over 4

=item * C<<< 200 >>> - status, type: application/json

The updated synchronization status for the repository, after enabling
synchronization. 204 NO CONTENT is returned instead after disabling
synchronization.

=item * C<<< 400 >>> - errors, type: application/json

The JSON payload for the request did not define the "enabled" property.

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user has insufficient permissions to manage
synchronization in the specified repository.

=item * C<<< 204 >>> - data, type: application/json

Synchronization has successfully been disabled. 200 OK, with updated status
information, is returned instead after enabling synchronization.

=item * C<<< 404 >>> - errors, type: application/json

The specified repository does not exist.

=back

=head2 get_status

Retrieves the synchronization status for the specified repository. In addition to listing refs which cannot be
synchronized, if any, the status also provides the timestamp for the most recent synchronization and indicates
whether synchronization is available and enabled. If "?at" is specified in the URL, the synchronization status
for the specified ref is returned, rather than the complete repository status.

The authenticated user must have B<<< REPO_READ >>> permission for the repository, or it must be public if the
request is anonymous. Additionally, after synchronization is enabled for a repository, meaning synchronization
was available at that time, permission changes and other actions can cause it to become unavailable. Even when
synchronization is enabled, if it is no longer available for the repository it will not be performed.

    GET sync/1.0/projects/{projectKey}/repos/{repositorySlug}

Parameters:

=over 4

=item * C<<< at >>> - string, default: none

retrieves the synchronization status for the specified ref within the repository, rather than for
the entire repository

=back

Responses:

=over 4

=item * C<<< 200 >>> - status, type: application/json

Synchronization status for the specified repository, or specific ref within
that repository.

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user has insufficient permissions to view the
repository, or the repository is not public if the request is anonymous.

=item * C<<< 404 >>> - errors, type: application/json

The specified repository does not exist.

=back

=head2 synchronize

Allows developers to apply a manual operation to bring a ref back in sync with upstream when it becomes out of
sync due to conflicting changes. The following actions are supported:

=over 4

=item *

C<<< MERGE >>>: Merges in commits from the upstream ref. After applying this action, the synchronized
ref will be C<<< AHEAD >>> (as it still includes commits that do not exist upstream.

=over 4

=item *

This action is only supported for C<<< DIVERGED >>> refs

=item *

If a "commitMessage" is provided in the context, it will be used on the merge commit. Otherwise a
default message is used.

=back

=item *

C<<< DISCARD >>>: I<<< Throws away >>> local changes in favour of those made upstream. This is a
I<<< destructive >>> operation where commits in the local repository are lost.

=over 4

=item *

No context entries are supported for this action

=item *

If the upstream ref has been deleted, the local ref is deleted as well

=item *

Otherwise, the local ref is updated to reference the same commit as upstream, even if the update
is not fast-forward (similar to a forced push)

=back

=back

The authenticated user must have B<<< REPO_WRITE >>> permission for the specified repository. Anonymous users
cannot synchronize refs, even on public repositories. Additionally, synchronization must be I<<< enabled >>> and
I<<< available >>> for the specified repository.

    POST sync/1.0/projects/{projectKey}/repos/{repositorySlug}/synchronize

Responses:

=over 4

=item * C<<< 200 >>> - status, type: application/json

The requested action was successfully performed, and has updated the ref's
state, but the ref if is still not in sync with upstream. For example, after
applying the C<<< MERGE >>> action, the ref will still be C<<< AHEAD >>> of
upstream. If the action brings the ref in sync with upstream, 204 NO CONTENT
is returned instead.

=item * C<<< 400 >>> - errors, type: application/json

The requested synchronization action was not understood.

=item * C<<< 401 >>> - errors, type: application/json

The currently authenticated user has insufficient permissions to update refs
within the specified repository.

=item * C<<< 204 >>> - data, type: application/json

The requested action was successfully performed and the ref is now in sync
with upstream. If the action updates the ref but does not bring it in sync
with upstream, 200 OK is returned instead.

=item * C<<< 501 >>> - errors, type: application/json

The requested synchronization action was understood by the server, but the
mechanism to apply it has not been implemented.

=item * C<<< 404 >>> - errors, type: application/json

The specified repository does not exist.

=item * C<<< 409 >>> - errors, type: application/json

Synchronization is not available or enabled for the specified repository, or
the ref is already in sync with upstream.

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
