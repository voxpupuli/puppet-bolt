# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v1.7.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.7.0) (2025-01-31)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.6.0...v1.7.0)

**Implemented enhancements:**

- puppetlabs/apt: Allow 10.x [\#49](https://github.com/voxpupuli/puppet-bolt/pull/49) ([bastelfreak](https://github.com/bastelfreak))

## [v1.6.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.6.0) (2024-12-16)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.5.0...v1.6.0)

**Implemented enhancements:**

- Add Debian 12 support [\#48](https://github.com/voxpupuli/puppet-bolt/pull/48) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Apt: Ensure apt-update runs before installing bolt [\#46](https://github.com/voxpupuli/puppet-bolt/pull/46) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- puppet/systemd: allow 8.x [\#45](https://github.com/voxpupuli/puppet-bolt/pull/45) ([jay7x](https://github.com/jay7x))

## [v1.5.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.5.0) (2024-11-26)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.4.0...v1.5.0)

**Implemented enhancements:**

- saz/sudo: Allow 9.x [\#43](https://github.com/voxpupuli/puppet-bolt/pull/43) ([bastelfreak](https://github.com/bastelfreak))

## [v1.4.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.4.0) (2024-11-14)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.3.0...v1.4.0)

**Implemented enhancements:**

- bolt project: Make PuppetDB URIs configureable [\#41](https://github.com/voxpupuli/puppet-bolt/pull/41) ([bastelfreak](https://github.com/bastelfreak))

## [v1.3.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.3.0) (2024-11-01)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.2.2...v1.3.0)

**Implemented enhancements:**

- Add support for setting tmpdir for local transport [\#39](https://github.com/voxpupuli/puppet-bolt/pull/39) ([bastelfreak](https://github.com/bastelfreak))

## [v1.2.2](https://github.com/voxpupuli/puppet-bolt/tree/v1.2.2) (2024-10-15)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.2.0...v1.2.2)

**Fixed bugs:**

- Raise proper error when fact `pe_status_check_role` is missing [\#37](https://github.com/voxpupuli/puppet-bolt/pull/37) ([bastelfreak](https://github.com/bastelfreak))

## [v1.2.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.2.0) (2024-09-27)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.1.1...v1.2.0)

**Implemented enhancements:**

- Add Debian OS family support [\#35](https://github.com/voxpupuli/puppet-bolt/pull/35) ([bastelfreak](https://github.com/bastelfreak))

## [v1.1.1](https://github.com/voxpupuli/puppet-bolt/tree/v1.1.1) (2024-07-30)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.1.0...v1.1.1)

**Fixed bugs:**

- bolt project: Include PE module path [\#31](https://github.com/voxpupuli/puppet-bolt/pull/31) ([bastelfreak](https://github.com/bastelfreak))
- set bolt version from 3.29.0 to installed [\#30](https://github.com/voxpupuli/puppet-bolt/pull/30) ([bastelfreak](https://github.com/bastelfreak))

## [v1.1.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.1.0) (2024-07-22)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v1.0.0...v1.1.0)

**Implemented enhancements:**

- Make repo management optional [\#28](https://github.com/voxpupuli/puppet-bolt/pull/28) ([bastelfreak](https://github.com/bastelfreak))

## [v1.0.0](https://github.com/voxpupuli/puppet-bolt/tree/v1.0.0) (2024-07-02)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v0.3.0...v1.0.0)

**Implemented enhancements:**

- yumrepo: make base\_url more flexible [\#24](https://github.com/voxpupuli/puppet-bolt/pull/24) ([bastelfreak](https://github.com/bastelfreak))

## [v0.3.0](https://github.com/voxpupuli/puppet-bolt/tree/v0.3.0) (2024-06-24)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v0.2.0...v0.3.0)

**Implemented enhancements:**

- Implement version=absent to remove bolt [\#22](https://github.com/voxpupuli/puppet-bolt/pull/22) ([bastelfreak](https://github.com/bastelfreak))
- Increase acceptance test coverage [\#21](https://github.com/voxpupuli/puppet-bolt/pull/21) ([bastelfreak](https://github.com/bastelfreak))

## [v0.2.0](https://github.com/voxpupuli/puppet-bolt/tree/v0.2.0) (2024-06-17)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/v0.1.0...v0.2.0)

**Breaking changes:**

- Drop EoL RedHat 7 [\#19](https://github.com/voxpupuli/puppet-bolt/pull/19) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL CentOS 7/8 [\#18](https://github.com/voxpupuli/puppet-bolt/pull/18) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- README.md: Switch puppetmodule.info link to https [\#17](https://github.com/voxpupuli/puppet-bolt/pull/17) ([bastelfreak](https://github.com/bastelfreak))

## [v0.1.0](https://github.com/voxpupuli/puppet-bolt/tree/v0.1.0) (2024-05-27)

[Full Changelog](https://github.com/voxpupuli/puppet-bolt/compare/4b4c88b6ad8eadab239d3a78f4931a80bd03aea2...v0.1.0)

**Implemented enhancements:**

- bolt::project: Add basic acceptance test [\#9](https://github.com/voxpupuli/puppet-bolt/pull/9) ([bastelfreak](https://github.com/bastelfreak))
- Add unit  tests for bolt::project [\#7](https://github.com/voxpupuli/puppet-bolt/pull/7) ([bastelfreak](https://github.com/bastelfreak))
- Add basic acceptance test [\#6](https://github.com/voxpupuli/puppet-bolt/pull/6) ([bastelfreak](https://github.com/bastelfreak))
- Add types and documentation for all parameters [\#5](https://github.com/voxpupuli/puppet-bolt/pull/5) ([bastelfreak](https://github.com/bastelfreak))
- init.pp: Add puppet-strings documentation [\#4](https://github.com/voxpupuli/puppet-bolt/pull/4) ([bastelfreak](https://github.com/bastelfreak))
- Add Unit testing [\#3](https://github.com/voxpupuli/puppet-bolt/pull/3) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- bolt::project: fail if we are not on PE [\#10](https://github.com/voxpupuli/puppet-bolt/pull/10) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- bolt::project: drop unused plans parameter [\#12](https://github.com/voxpupuli/puppet-bolt/pull/12) ([bastelfreak](https://github.com/bastelfreak))
- Add README.md, update puppet-strings docs [\#11](https://github.com/voxpupuli/puppet-bolt/pull/11) ([bastelfreak](https://github.com/bastelfreak))
- acceptance tests: properly cleanup between tests [\#8](https://github.com/voxpupuli/puppet-bolt/pull/8) ([bastelfreak](https://github.com/bastelfreak))
- Add AGPL-3 license [\#2](https://github.com/voxpupuli/puppet-bolt/pull/2) ([bastelfreak](https://github.com/bastelfreak))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
