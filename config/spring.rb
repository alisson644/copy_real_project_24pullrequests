%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmb/caching-dev.txt
).each { |path| Spring.watch(path) }