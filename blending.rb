require 'active_support/concern' 
module Blending extend ActiveSupport::Concern

included do
    after_save :make_juice 
end

def method_missing(m_name,*args,&block)
    if m_name.to_s == "make_juice" && self.class.to_s == "Apple"
        puts "Makes #{self.class} juice"
    end
end


end

class Apple
	include Blending


end	

class Orange
	include Blending
end



apple = Apple.new
apple.make_juice
