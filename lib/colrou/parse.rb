module Colrou
  class Parse
    def self.rails_routes
      if ARGF.filename != "-" or (not STDIN.tty? and not STDIN.closed?)
        RailsRoutesParser.parse
     else
        puts %{
Reformats output of `rails routes`:
- HTTP verbs and path parameters are colorized
- Line breaks are inserted between controllers

Usage examples:

$ rails routes | colrou
$ rails routes -g posts | colrou

}
      end
    end
  end

  class RailsRoutesParser
    RED         = "\e[91m"
    GREEN       = "\e[92m"
    YELLOW      = "\e[93m"
    PURPLE      = "\e[95m"
    CYAN        = "\e[96m"
    RESET_COLOR = "\e[0m"

    VERBS_AND_COLORS = [
      { verb: "DELETE", color: RED    },
      { verb: "GET",    color: GREEN  },
      { verb: "PATCH",  color: PURPLE },
      { verb: "POST",   color: YELLOW },
      { verb: "PUT",    color: PURPLE }
    ]

    def self.colorize_verbs(line)
      VERBS_AND_COLORS.each do |verb_and_color|
        verb = verb_and_color[:verb]
        color = verb_and_color[:color]
        line.gsub!(/#{verb}/, "#{color}#{verb}#{RESET_COLOR}")
      end
    end

    # Uses https://ruby-doc.org/core-1.9.3/Regexp.html#class-Regexp-label-Capturing
    def self.colorize_parameters(line)
      line.gsub!(/(?<parameter>\/:\w+)/) do
        "/#{CYAN}#{$~[:parameter].slice(1..-1)}#{RESET_COLOR}"
      end
    end

    def self.extract_controller_name(line)
      controller_action = line[/\w+#\w+$/] # Find "controller#action\n"
      return if nil == controller_action
      controller_action.split("#")[0]      # Get "controller" from "controller#action"
    end

    def self.parse
      prev_controller_name = nil
      begin
        while input = ARGF.gets
          input.each_line do |line|
            begin
              # Apply colorizations
              colorize_verbs(line)
              colorize_parameters(line)
              # Apply line breaks between controllers
              controller_name = extract_controller_name(line)
              $stdout.puts if controller_name != prev_controller_name && nil != prev_controller_name
              prev_controller_name = controller_name
              # Output formatted line
              $stdout.puts(line)
            rescue Errno::EPIPE
              exit(74) # Bash exit status code (input/output error)
            end
          end
        end
      rescue
        puts "Invalid input"
      end
    end
  end
end
