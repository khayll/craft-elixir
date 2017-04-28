defmodule OTP.Echo do
    def start_link do
        # m, f, a
        pid = spawn_link(OTP.Echo, :loop, [])
        {:ok, pid}
    end

    def loop do
        
    end
end