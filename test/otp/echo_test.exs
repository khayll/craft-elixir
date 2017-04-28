defmodule OTP.EchoTest do
    use ExUnit.Case, async: true

    test "echo" do
        {:ok, pid} = Echo.start_link()

        Echo.send(pid, :hello)
        assert_receive :hello
    end
end