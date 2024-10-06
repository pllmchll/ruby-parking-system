def create_parking_lot(size)
    $lot = Array.new(size.to_i)
    puts "Created a parking lot with #{size} slots"
end

def park(plate, color)
    if $lot.size == 0
        puts "Parking lot is not created yet"
    elsif !$lot.include?(nil)
        puts "Parking lot is full"
    else
        slot = $lot.find_index(nil)
        $lot[slot] = {plate:, color:}
        puts "Allocated slot number: #{slot+1}"
    end
end

def leave(slot)
    if $lot.size == 0
        puts "Parking lot is not created yet"
    elsif slot.to_i < 1 or slot.to_i > $lot.size
        puts "Slot number #{slot} doesn't exist"
    else
        $lot[(slot.to_i)-1] = nil
        puts "Slot number #{slot} is free"
    end
end

def status()
    if $lot.size == 0
        puts "Parking lot is not created yet"
    elsif $lot.all?(&:nil?)
        puts "Parking lot is empty"
    else
        puts "Slot No. | Plate Number | Colour"
        for i in 0..$lot.size
            unless $lot[i].nil?
                puts "#{i+1} | #{$lot[i][:plate]} | #{$lot[i][:color]}"
            end
        end
    end
end

def quit()
    exit
end

$lot = Array.new
$commands = {
    "create_parking_lot"                    => method(:create_parking_lot),
    "park"                                  => method(:park),
    "leave"                                 => method(:leave),
    "status"                                => method(:status),
    "quit"                                  => method(:quit)
}

# main program
loop do
    print "> "
    input = gets.chomp

    command = input.split[0]
    args = input.split[1..]

    begin
        $commands[command].call(*args)
    rescue NoMethodError => e
        puts "Error: invalid command #{command}"
        next
    rescue ArgumentError => e
        given = e.message.split[-3].chr.to_i
        expected = e.message.split[-1].chr.to_i
        puts (given-expected) < 0 ? "Error: not enough parameters" : "Error: too many parameters"
        next
    end
end
