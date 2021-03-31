defmodule Recaptcha.HttpTest do
  use ExUnit.Case, async: true

  alias Recaptcha.Http

  @valid_response %{
    success: true,
    challenge_ts: DateTime.utc_now() |> DateTime.to_unix(),
    hostname: "localhost",
    score: 1
  }
  setup do
    bypass = Bypass.open()

    Application.put_env(
      :recaptcha,
      :verify_url,
      "http://localhost:#{bypass.port}"
    )

    {:ok, bypass: bypass}
  end

  test "handle successful request", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert conn.request_path == "/"
      assert conn.method == "POST"

      Plug.Conn.resp(conn, 200, Jason.encode!(@valid_response))
    end)

    assert {:ok, _} = Http.request_verification("response=valid_response")
  end

  test "handle non sucessful request", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      assert conn.request_path == "/"
      assert conn.method == "POST"

      response =
        %{@valid_response | success: false}
        |> Map.put_new("error-codes", ["bad-request"])

      Plug.Conn.resp(
        conn,
        200,
        Jason.encode!(response)
      )
    end)

    assert {:ok, %{"error-codes" => ["bad-request"]}} =
             Http.request_verification("response=invalid")
  end
end
