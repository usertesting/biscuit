# 0.2.0
- [FIX] Resolve File.exists? deprecation removal in latest Ruby.
- Bump upstream biscuit binary dependency to latest 0.1.4 release.
- Adds diagnostic logging to install task.

# 0.1.4
- [FIX] `open()` is deprecated for URIs. Uses `URI.open()`
- Bumps bundler version
- Bumps rake gem version

# 0.1.3
- No changes - apparently there was already a yanked 0.1.2 out there somewhere

# 0.1.2

- [FIX] Revert to using `YAML.load` to load the secrets
- [FIX] Don't split values containing `:` into broken pieces
- Relax `rake` dependency
- [DOC] Fill out README
- Set up CI
- Gitignore the actual `biscuit` binary
