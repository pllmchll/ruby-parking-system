loop do
    print "input: "
    input = gets.chomp

    command = input.split[0]
    args = input.split[1..]

    if (command == "quit")
        break
    end

    puts "command: " + command
    puts "args: " + args.to_s
    puts
end
