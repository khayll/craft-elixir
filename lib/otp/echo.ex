defmodule OTP.Echo do
    @receive_timeout 50

    def start_link do
        # m, f, a
        #pid = spawn_link(OTP.Echo, :loop, [])

        #using spwan_link with the loop function with 0 parameters
        pid = spawn_link(&loop/0)
        {:ok, pid}
    end

    def sync_send(pid, msg) do
        async_send(pid, msg)
        receive do 
            msg -> msg
        end
    end

    def async_send(pid, msg) do
        Kernel.send(pid, {msg, self()})
    end

    #p in defp makes it private
    defp loop do
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