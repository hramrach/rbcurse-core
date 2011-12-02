# this program tests out various widgets.
require 'logger'
require 'rbcurse'
require 'rbcurse/core/widgets/rlist'
require 'rbcurse/core/widgets/rtextview'
require 'rbcurse/core/include/vieditable'
#require 'rbcurse/experimental/widgets/undomanager'
class RubyCurses::List
  # vieditable includes listeditable which
  # does bring in some functions which can crash program like x and X TODO
  # also, f overrides list f mapping. TODO
  include ViEditable
end
if $0 == __FILE__
  include RubyCurses

  begin
  # Initialize curses
    VER::start_ncurses  # this is initializing colors via ColorMap.setup
    $log = Logger.new((File.join(ENV["LOGDIR"] || "./" ,"rbc13.log")))
    $log.level = Logger::DEBUG

    @window = VER::Window.root_window
    $catch_alt_digits = true; # emacs like alt-1..9 numeric arguments
    # Initialize few color pairs 
    # Create the window to be associated with the form 
    # Un post form and free the memory

    catch(:close) do
      colors = Ncurses.COLORS
      $log.debug "START #{colors} colors testlistbox.rb --------- #{@window} "
      @form = Form.new @window
      @form.window.printstring 0, 30, "Demo of Listbox - some vim keys", $normalcolor, BOLD
      r = 1; fc = 1;

      $results = Variable.new
      $results.value = "F10 quits. Try j k gg G o O C dd f<char> w yy p P / . Press ENTER on Class or Method"
      var = RubyCurses::Label.new @form, {'text_variable' => $results, "row" => FFI::NCurses.LINES-2, 
        "col" => fc, "display_length" => 100, "height" => 1}
      h = FFI::NCurses.LINES-3
      file = "./data/ports.txt"
      #mylist = File.open(file,'r').readlines 
      mylist = `ri -f bs`.split("\n")
      w = 25
      #0.upto(100) { |v| mylist << "#{v} scrollable data" }
      listb = List.new @form do
        name   "mylist" 
        row  r 
        col  1 
        width w
        height h
        list mylist
        selection_mode :SINGLE
        show_selector true
        #row_selected_symbol "[X] "
        #row_unselected_symbol "[ ] "
        title " Ruby Classes "
        #title_attrib 'reverse'
      end
      listb.one_key_selection = false # this allows us to map keys to methods
      listb.vieditable_init_listbox
      include Io
      listb.bind_key(?r){ get_file("Get a file:", 70) }
      listb.bind(:PRESS) { 
        w = @form.by_name["tv"]; 
        lines = `ri -f bs #{listb.text}`.split("\n")
        #w.set_content(lines); 
        w.formatted_text(lines, :ansi)
        w.title = listb.text
      }

      tv = RubyCurses::TextView.new @form, :row => r, :col => w+1, :height => h, :width => FFI::NCurses.COLS-w-1,
      :name => "tv", :title => "Press Enter on method"
      tv.set_content ["Press Enter on list to view ri information in this area.", 
        "Press ENTER on method name to see details"]
      tv.bind(:PRESS) { |ev|
        w = ev.word_under_cursor.strip
        text = `ri -f bs #{tv.title}.#{w}` rescue "Not details for #{w}"
        text = text.split("\n")
        temptext = ["sending in","some text"]
        view(temptext) do |t|
          t.formatted_text(text, :ansi)
        end
      }

      #undom = SimpleUndo.new listb


=begin
    # using ampersand to set mnemonic
    col = FFI::NCurses.COLS-10
    row = FFI::NCurses.LINES-2
    cancel_button = Button.new @form do
      text "&Close"
      row row
      col col
    end
    cancel_button.command { |form| 
      if confirm("Do your really want to quit?")
        throw(:close); 
      else
        $message.value = "Quit aborted"
      end
    }

=end

    @form.repaint
    @window.wrefresh
    Ncurses::Panel.update_panels
    while((ch = @window.getchar()) != KEY_F10 )
      @form.handle_key(ch)
      @window.wrefresh
    end
  end
rescue => ex
ensure
  @window.destroy if !@window.nil?
  VER::stop_ncurses
  p ex if ex
  p(ex.backtrace.join("\n")) if ex
  $log.debug( ex) if ex
  $log.debug(ex.backtrace.join("\n")) if ex
end
end
