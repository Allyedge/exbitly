defmodule Exbitly do
  @moduledoc """
  Exbitly's main module. You can find all the functions you can use in Exbitly in this module.
  """

  @doc """
  Takes a domain and a long URL and returns the shortened URL. If an error occurs, returns the error body.

  ## Parameters

  - `domain`: The domain of the shortened URL.
  - `long_url`: The long URL to be shortened.

  ## Examples

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
  """
  @spec shorten(String.t(), String.t()) ::
          {:ok, String.t()} | {:error, map()}
  def shorten(domain, long_url) when is_binary(domain) and is_binary(long_url) do
    body = Poison.encode!(%{domain: domain, long_url: long_url})

    {:ok, response} = Exbitly.Base.post("https://api-ssl.bitly.com/v4/shorten", body)

    response = Poison.decode!(response.body)

    if response["link"] != nil do
      {:ok, response["link"]}
    else
      {:error, response}
    end
  end

  @doc """
  Takes a domain and a long URL and returns the shortened URL. If an error occurs, raises an exception.

  ## Parameters

  - `domain`: The domain of the shortened URL.
  - `long_url`: The long URL to be shortened.

  ## Examples

  ```elixir
  Exbitly.shorten!("bit.ly", "http://www.example.com")
  # {:ok, "http://bit.ly/short_url"}

  Exbitly.shorten!("random", "http://www.example.com")
  # ** (Exbitly.Error) An error occured while shortening the URL. Message: INVALID_ARG_DOMAIN - Description: The value provided is invalid.
  ```
  """
  @spec shorten!(String.t(), String.t()) ::
          {:ok, String.t()} | no_return()
  def shorten!(domain, long_url) when is_binary(domain) and is_binary(long_url) do
    body = Poison.encode!(%{domain: domain, long_url: long_url})

    {:ok, response} = Exbitly.Base.post("https://api-ssl.bitly.com/v4/shorten", body)

    response = Poison.decode!(response.body)

    message = response_or_empty(response["message"], "No Message")
    description = response_or_empty(response["description"], "No Description")

    if response["link"] != nil do
      {:ok, response["link"]}
    else
      raise(Exbitly.Error,
        message:
          "An error occured while shortening the URL. Message: #{message} - Description: #{description}"
      )
    end
  end

  @spec response_or_empty(any(), String.t()) :: any() | String.t()
  defp response_or_empty(response, empty) do
    if response != nil do
      response
    else
      empty
    end
  end
end
