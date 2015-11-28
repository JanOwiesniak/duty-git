# Duty::Git

git specific tasks for the duty task manager

## Installation

```
tasks:
  git: path/to/duty-git/lib/duty/git.rb
```

## Usage

```
duty
```

## Tasks

### StartFeature

Start a new feature

```
duty start-feature <feature-name>
```

### ContinueFeature

Continue on an already existing feature

```
duty continue-feature <feature-name>
```

### DeleteFeature

Delete a feature

```
duty delete-feature <feature-name>
```

### MergeFeature

Merge a feature into `master`

```
duty merge-feature <feature-name>
```

## Contributing

1. [Fork](http://github.com/JanOwiesniak/duty-git/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
