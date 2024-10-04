def create_parking_lot(size)
    # function logic goes here
    
    puts "Created a parking lot with " + size + " slots"
end

def park(plate, color)
    # function logic goes here

    puts "Allocated slot number: n"
end

def leave(slot)
    # function logic goes here

    puts "Slot number " + slot + " is free"
end

def quit()
    $run_program = false
end

$run_program = true
$commands = {
    "create_parking_lot" => {
        "method"    => method(:create_parking_lot),
        "arg_count" => 1
    },
    "park" => {
        "method"    => method(:park),
        "arg_count" => 2
    },
    "leave" => {
        "method"    => method(:leave),
        "arg_count" => 1
    },
    "quit" => {
        "method"    => method(:quit),
        "arg_count" => 0
    }
}

# main program
while $run_program == true do
    print "> "
    input = gets.chomp

    key = input.split[0]
    args = input.split[1..]

    if $commands.key?(key)
        command = $commands[key]
        if args.length() < command["arg_count"]
            puts "Error: not enough parameters"
        elsif args.length() > command["arg_count"] 
            puts "Error: too many parameters"
        else
            command["method"].call(*args)
        end
    else
        puts "Error: invalid command"
    end
end
