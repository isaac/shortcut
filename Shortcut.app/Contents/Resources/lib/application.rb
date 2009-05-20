require "shortcut"
require 'hotcocoa'

include HotCocoa

application do |app|
      
  def install_shortcut
    shortcut = Shortcut.new
    shortcut.delegate = self
    shortcut.addShortcut
  end
  
  def hotkeyWasPressed
    window :size => [250, 50] do |win|
      my_label = label(:text => "You pressed Control+Option+Space", :layout => {:expand => :width, :start => false})
      win << my_label
    end
  end
  
  window :size => [200, 50] do |win|
    b = button :title => 'Install Carbon Shortcut'
    b.on_action { install_shortcut; puts "Installed KeyBoard shortcut, type Control+Option+Space" }
    win << b # Sugar for adding a subview.
    win.will_close { puts "goodbye"; exit } # Delegate method--implemented!
  end
end