# -*- encoding : utf-8 -*-
RestyAtp::Application.configure do
  silence_warnings do
    begin
      require 'pry'
      IRB = Pry
    rescue LoadError
    end
  end
end
