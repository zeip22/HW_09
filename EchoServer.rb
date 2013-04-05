require 'socket'
def run(client,n)
	puts "New Communication Thread Started"
	begin
		while 
			inmsg = client.gets
			puts "Client##{n} says:"+inmsg
			ex = "Bye."
			if ex.eql?(inmsg.chomp)
				puts "Client##{n} has left."
			else
				client.puts inmsg
			end
		end
	rescue Exception => e
		puts "Problem with Communication Server"
		exit
	end
end

server = nil
begin
	server = TCPServer.new "127.0.0.1",11111
	puts "Connection Socket Created"
	n = 0
	begin
		loop do
			puts "Waiting for Connection"
			client = server.accept
			Thread.new{run client,n}
			n = n+1
		end	
	rescue Exception => e
		puts "Accept failed."
		exit
	end

rescue Exception => msg
	puts "Could not listen on port: 10008."
	exit
end

