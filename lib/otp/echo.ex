defmodule OTP.Echo do
    @receive_timeout 50

    def start_link do
        # m, f, a
        pid = spawn_link(OTP.Echo, :loop, [])
        {:ok, pid}
    end

    def send(pid, msg) do
        Kernel.send(pid, {msg, self()})
    end

    def loop do
        receive do
           {msg, caller} ->
               Kernel.send(caller, msg)
               loop()
            # catch all to prevent memory overflow
            _msg ->
                loop()
        after
            @receive_timeout ->
                exit(:normal)
        end
    end
end