defmodule OTP.EchoTest do
    use ExUnit.Case, async: true

    alias OTP.Echo

    test "echo" do
        {:ok, pid} = Echo.start_link()

        Echo.async_send(pid, :hello)
        assert_receive :hello

        Echo.async_send(pid, :hello)
        assert_receive :hello

        send(pid, :another_message)
        assert Process.alive?(pid)
    end

    test "times out after 50 ms" do
        {:ok, pid} = Echo.start_link()
        
        Process.sleep(51)
        refute Process.alive?(pid)
    end

    test "sync echo" do
        {:ok, pid} = Echo.start_link()

        assert :hello == Echo.sync_send(pid, :hello)
    end

    test "sync send timeout" do
        {:ok, pid} = Echo.start_link()

        assert {:error, :timeout} = Echo.sync_send(pid, :no_reply)
    end

    test "sync msg race condition" do
        {:ok, pid} = Echo.start_link()

        Kernel.send(self(), :long_computation)
        assert :long_computation == Echo.sync_send(pid, :no_reply)        
    end
end