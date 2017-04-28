defmodule OTP.EchoTest do
    use ExUnit.Case, async: true

    alias OTP.Echo

    test "echo" do
        {:ok, pid} = Echo.start_link()

        Echo.send(pid, :hello)
        assert_receive :hello
    end
end