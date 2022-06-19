# Exbitly

[![Hex.pm](https://img.shields.io/hexpm/v/exbitly.svg?style=flat)](https://hex.pm/packages/exbitly)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/exbitly.svg?style=flat)](https://hex.pm/packages/exbitly)

An Elixir library to interact with the Bitly API.

## Installation

To use Exbitly, you first have to add it to your `mix.exs` dependencies.

```elixir
defp deps do
    [
      {:exbitly, "~> 0.1.0"}
    ]
end
```

After that, you have to create a `config` folder and a `config.exs` file inside that folder.
Then, pass the code below inside the `config.exs` file and add your token in it.

```elixir
import Config

config :exbitly,
  token: ""
```

Without the `config.exs` file, you won't be able to shorten URLs.

## Usage

You can use `shorten/2` to shorten a URL.

```elixir
Exbitly.shorten("bit.ly", "http://www.example.com")
# {:ok, "http://bit.ly/short_url"}

Exbitly.shorten("random", "http://www.example.com")
# {:error, %{
#   "description" => "The value provided is invalid.",
#   "errors" => [%{"error_code" => "invalid", "field" => "domain"}],
#   "message" => "INVALID_ARG_DOMAIN",
#   "resource" => "bitlinks"
# }}
```

If you prefer exceptions, you can always use `shorten!/2` instead of `shorten/2`.

```elixir
Exbitly.shorten!("bit.ly", "http://www.example.com")
# {:ok, "http://bit.ly/short_url"}

Exbitly.shorten!("random", "http://www.example.com")
# ** (Exbitly.Error) An error occured while shortening the URL. Message: INVALID_ARG_DOMAIN - Description: The value provided is invalid.
```

## License

Copyright (c) 2022-present Alim Arslan Kaya.

Exbitly is licensed under the MIT license.
