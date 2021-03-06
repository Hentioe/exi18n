# ExI18n

[![hex.pm version](https://img.shields.io/hexpm/v/exi18n.svg)](https://hex.pm/packages/exi18n) [![Build Status](https://travis-ci.org/gvl/exi18n.svg?branch=master)](https://travis-ci.org/gvl/exi18n) [![Coverage Status](https://coveralls.io/repos/gvl/exi18n/badge.svg?branch=master)](https://coveralls.io/r/gvl/exi18n?branch=master) [![Inline docs](http://inch-ci.org/github/gvl/exi18n.svg?branch=master&style=shields)](http://inch-ci.org/github/gvl/exi18n)

**ExI18n** is key-based internationalization library for Elixir.

## Table of Contents

* [Installation](#installation)
* [Configuration](#configuration)
  * [Configuration parameters](#configuration-parameters)
* [Loaders](#loaders)
  * [YAML](#yaml)
  * [Custom](#custom)
* [Documentation](#documentation)

## Installation

Add `exi18n` to your list of dependencies and to `applications` in `mix.exs`:

```elixir
# mix.exs

def deps do
  [
    {:exi18n, "~> 0.9.0"},
  ]
end

def application do
  [applications: [
    :exi18n,
  ]]
end
```

## Configuration

Add configuration to your `config/config.exs`:

```elixir
# config.exs

config :exi18n,
  default_locale: "en",
  locales: ~w(en),
  fallback: false,
  loader: :yml,
  loader_options: %{path: "priv/locales"},
  var_prefix: "%{",
  var_suffix: "}"
```

### Configuration parameters

| Option | Description | Default |
| :-- | :-- | :--: |
| default_locale | Default locale in your application. | `"en"` |
| locales | Supported locales. | `["en"]` |
| fallback | Fallback to default locale if translation empty. | `false` |
| loader | Translation loader. Supported types: `:yml`, `:http`, `MyApp.Loader`. | `:yml` |
| loader_options | Translation loader options. | `%{}` |
| var_prefix | Prefix for values in translations. | `"%{"` |
| var_suffix | Suffix for values in translations. | `"}"` |

## Loaders

### YAML

This loader will use yaml files from `path` to load translations.

#### Module

`ExI18n.Loader.YAML`

#### Dependencies

```elixir
# mix.exs

def deps do
  [
    {:exi18n, "~> 0.9.0"},
    {:yaml_elixir, "~> 2.0"},
  ]
end

def application do
  [applications: [
    :exi18n,
    :yaml_elixir,
  ]]
end
```

#### Configuration

| Option | Required | Description |
| :-- | :--: | :-- |
| path | **Yes** | Path to locale files. |

```elixir
# config.exs

config :exi18n,
  loader: :yml,
  loader_options: %{
    path: "priv/locales" # or {MyHelper, :path, ["priv/locales"]}
  }
```

### Custom

#### Module

`MyApp.Loader`

Make sure that your custom loader has `load/2` function that accepts `locale` and `options` as parameters and returns `Map` with translations.

Example:

```elixir
defmodule MyApp.Loader do
  def load(locale, _options) do
    %{
      "en" => %{...},
      "de" => %{...}
    }[locale]
  end
end
```

#### Dependencies

```elixir
# mix.exs

def deps do
  [
    {:exi18n, "~> 0.9.0"},
  ]
end

def application do
  [applications: [
    :exi18n,
  ]]
end
```

#### Configuration

```elixir
# config.exs

config :exi18n,
  loader: MyApp.Loader,
  loader_options: %{my_config: "value"}
```

## Documentation

[https://hexdocs.pm/exi18n](https://hexdocs.pm/exi18n)
