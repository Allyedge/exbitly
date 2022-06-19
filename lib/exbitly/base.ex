defmodule Exbitly.Base do
  use HTTPoison.Base

  @token Application.fetch_env!(:exbitly, :token)

  def process_request_headers(headers) do
    [{"Authorization", "Bearer #{@token}"}, {"Content-Type", "application/json"} | headers]
  end
end
