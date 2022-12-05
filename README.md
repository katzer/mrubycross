# skatzer/mrubycross:kinetic

Cross compile mruby binaries for __linux-gnu__, __musl__, __darwin__ and __win32__.

## How to use

For _linux-gnu_ add this target to your `build_config.rb`:

```ruby
MRuby::Build.new('x86_64-pc-linux-gnu') do |conf|
  toolchain :clang
end
```

For _musl_ add this target to your `build_config.rb`:

```ruby
MRuby::CrossBuild.new('x86_64-alpine-linux-musl') do |conf|
  toolchain :gcc

  [conf.cc, conf.linker].each do |cc|
    cc.command = 'musl-gcc'
  end
end
```

For _darwin-x64_ add this target to your `build_config.rb`:

```ruby
MRuby::CrossBuild.new('x86_64-apple-darwin19') do |conf|
  toolchain :clang

  [conf.cc, conf.linker].each do |cc|
    cc.command = 'x86_64-apple-darwin20.4-clang'
    cc.flags << '-mmacosx-version-min=10.15'
  end

  conf.cxx.command      = 'x86_64-apple-darwin20.4-clang++'
  conf.archiver.command = 'x86_64-apple-darwin20.4-ar'

  conf.build_target     = 'x86_64-pc-linux-gnu'
  conf.host_target      = 'x86_64-apple-darwin19'
end
```

For _darwin-arm64_ add this target to your `build_config.rb`:

```ruby
MRuby::CrossBuild.new('arm64-apple-darwin19') do |conf|
  toolchain :clang

  [conf.cc, conf.linker].each do |cc|
    cc.command = 'arm64-apple-darwin20.4-clang'
    cc.flags << '-mmacosx-version-min=10.15'
  end

  conf.cxx.command      = 'arm64-apple-darwin20.4-clang++'
  conf.archiver.command = 'arm64-apple-darwin20.4-ar'

  conf.build_target     = 'arm64-pc-linux-gnu'
  conf.host_target      = 'arm64-apple-darwin19'

  gem_config(conf)
end
```

For _win32_ add this target to your `build_config.rb`:

```ruby
MRuby::CrossBuild.new('x86_64-w64-mingw32') do |conf|
  toolchain :gcc

  [conf.cc, conf.linker].each do |cc|
    cc.command = 'x86_64-w64-mingw32-gcc'
  end

  conf.cxx.command      = 'x86_64-w64-mingw32-cpp'
  conf.archiver.command = 'x86_64-w64-mingw32-gcc-ar'
  conf.exts.executable  = '.exe'

  conf.build_target     = 'x86_64-pc-linux-gnu'
  conf.host_target      = 'x86_64-w64-mingw32'
end
```

## Development

See the build tasks:

    $ rake -T

## License

The code is available as open source under the terms of the [MIT License][license].

Made with :yum: from Leipzig

© 2022 Sebastián Katzer

[license]: https://opensource.org/licenses/MIT
