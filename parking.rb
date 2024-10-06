def create_parking_lot(size)
    $lot = Array.new(size.to_i)

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

def status()
    if $lot.size != 0
        if $lot.all?(&:nil?)
            puts "Parking lot is empty"
        else
            puts "Slot No. | Plate Number | Colour"
            for i in 0..$lot.size
                unless $lot[i].nil?
                    puts (i+1).to_s + " | " + $lot[i]["plate"].to_s + " | " + $lot[i]["color"].to_s
                end
            end
        end
    else
        puts "Create a parking lot first"
    end
end

def quit()
    exit
end

$lot = Array.new
$commands = {
    "create" => {
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
    "status" => {
        "method"    => method(:status),
        "arg_count" => 0
    },
    "quit" => {
        "method"    => method(:quit),
        "arg_count" => 0
    }
}

# main program
loop do
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
