If you follow these contributing guidelines your patch
will likely make it into a release a little quicker.


## Contributing

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms. [Contributor Code of Conduct](https://voxpupuli.org/coc/).

1. Fork the repo.

1. Create a separate branch for your change.

1. Run the tests. We only take pull requests with passing tests, and
   documentation.

1. Add a test for your change. Only refactoring and documentation
   changes require no new tests. If you are adding functionality
   or fixing a bug, please add a test.

1. Squash your commits down into logical components. Make sure to rebase
   against the current master.

1. Push the branch to your fork and submit a pull request.

Please be prepared to repeat some of these steps as our contributors review
your code.

## Dependencies

The testing and development tools have a bunch of dependencies,
all managed by [bundler](http://bundler.io/) according to the
[Puppet support matrix](http://docs.puppetlabs.com/guides/platforms.html#ruby-versions).

By default the tests use a baseline version of Puppet.

If you have Ruby 2.x or want a specific version of Puppet,
you must set an environment variable such as:

    export PUPPET_VERSION="~> 4.2.0"

Install the dependencies like so...

    bundle install

## Syntax and style

The test suite will run [Puppet Lint](http://puppet-lint.com/) and
[Puppet Syntax](https://github.com/gds-operations/puppet-syntax) to
check various syntax and style things. You can run these locally with:

    bundle exec rake lint
    bundle exec rake validate
    bundle exec rubocop

## Running the unit tests

The unit test suite covers most of the code, as mentioned above please
add tests if you're adding new functionality. If you've not used
[rspec-puppet](http://rspec-puppet.com/) before then feel free to ask
about how best to test your new feature.

To run your all the unit tests

    bundle exec rake spec SPEC_OPTS='--format documentation'

To run a specific spec test set the `SPEC` variable:

    bundle exec rake spec SPEC=spec/foo_spec.rb

To run the linter, rubocop, the syntax checker and the unit tests:

    bundle exec rake test   


## Integration tests

The unit tests just check the code runs, not that it does exactly what
we want on a real machine. For that we're using
[litmus](https://puppet.com/blog/litmus-new-module-acceptance-testing-tool/).

This fires up a new virtual machine (using vagrant) and runs a series of
simple tests against it after applying the module. You can run this
with:

    bundle exec rake 'litmus:provision_list[vagrant]
    bundle exec rake 'litmus:install_agent[puppet6]'`
    PUPPET_GEM_VERSION="~>6.0" bundle exec rake 'litmus:install_modules_from_directory'
    PUPPET_GEM_VERSION="~>6.0" bundle exec rake 'litmus:acceptance:127.0.0.1:2222'
    
Once executed and remove the virtual machine. You can destroy it with:

    PUPPET_GEM_VERSION="~>6.0" bundle exec rake 'litmus:tear_down'
# vim: syntax=markdown
