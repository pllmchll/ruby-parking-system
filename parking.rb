def create_parking_lot(size)
    $lot = Array.new(size.to_i)
    puts "Created a parking lot with #{size} slots"
end

def park(plate, color)
    if $lot.size == 0
        puts "Parking lot is not created yet"
    elsif !$lot.include?(nil)
        puts "Sorry, parking lot is full"
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

def plate_numbers_for_cars_with_colour(color)
    output = ""
    for car in $lot
        if !car.nil? and car[:color].downcase == color.downcase
            output << "#{car[:plate]}, "
        end
    end
    puts output.empty? ? "No cars found" : output[0..-3]
end

def slot_numbers_for_cars_with_colour(color)
    output = ""
    for i in 0..$lot.size
        if !$lot[i].nil? and $lot[i][:color].downcase == color.downcase
            output << "#{i+1}, "
        end
    end
    puts output.empty? ? "No cars found" : output[0..-3]
end

def slot_number_for_registration_number(plate)
    index = nil
    for i in 0..$lot.size
        if !$lot[i].nil? and $lot[i][:plate].downcase == plate.downcase
            index = "#{i+1}"
            break
        end
    end
    puts index.nil? ? "Not found" : index
end

def quit()
    exit
end

$lot = Array.new
$commands = {
    "create"                                => method(:create_parking_lot),
    "park"                                  => method(:park),
    "leave"                                 => method(:leave),
    "status"                                => method(:status),
    "plates_color"                          => method(:plate_numbers_for_cars_with_colour),
    "slots_color"                           => method(:slot_numbers_for_cars_with_colour),
    "slot_plate"                            => method(:slot_number_for_registration_number),
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
