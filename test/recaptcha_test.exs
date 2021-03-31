defmodule RecaptchaTest do
  use ExUnit.Case, async: true
  import Mox
  alias Recaptcha.Http.Mock

  setup :verify_on_exit!

  test "When the supplied g-recaptcha-response is invalid, multiple errors are returned" do
    Mock
    |> expect(:request_verification, fn _, _ ->
      {:error, [:invalid_input_secret]}
    end)

    assert {:error, messages} = Recaptcha.verify("not_valid")
    assert messages == [:invalid_input_secret]
  end

  test "When a valid response is supplied, a success response is returned" do
    Mock
    |> expect(:request_verification, fn _, _ -> {:ok, build_response()} end)

    assert {:ok, %{challenge_ts: _, hostname: _, score: _}} =
             Recaptcha.verify("valid_response")
  end

  defp build_response(overwrites \\ %{}) do
    Map.merge(
      %{
        "success" => true,
        "challenge_ts" => DateTime.utc_now(),
        "hostname" => "locahost",
        "score" => 1
      },
      overwrites
    )
  end
end
