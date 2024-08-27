# mrubycross

Cross compile mruby binaries for __linux-gnu__, __musl__, __darwin__ and __win32__.

Each branch is a seperate docker image:

#### [skatzer/mrubycross:bullseye][bullseye]
- up-to-date build toolchain as good as possible
- cross compile mruby binaries for different __glibc__ versions, __musl__, __darwin__ and __win32__

```sh
$ docker pull skatzer/mrubycross:bullseye
```

#### [skatzer/mrubycross:noble][noble]
- most recent up-to-date build toolchain
- cross compile mruby binaries for __linux-gnu__, __musl__, __darwin__ and __win32__
- linux binaries __wont__ launch on systems that have installed glibc 2.33 and earlier

```sh
$ docker pull skatzer/mrubycross:noble
```

## License

The code is available as open source under the terms of the [MIT License][license].

Made with :yum: from Leipzig

© 2022 Sebastián Katzer

[license]: https://opensource.org/licenses/MIT
[bullseye]: https://github.com/katzer/mrubycross/tree/bullseye
[noble]: https://github.com/katzer/mrubycross/tree/noble
