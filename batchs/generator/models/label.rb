module LabelArray
  refine Array do
    def hello
      puts "#{self} says : Hello, world"
    end
  end
end
  
class User
  using HelloWorld
  attr_reader :user
  
  def initialize(user)
    @user = user
  end
  
  def say
    user.hello
  end
end

class Label
  
  @@items = []
  
  def self.load(array)
    @@items = array
  end
  
  def initialize(hash)
    
  end
end

----

(array).each do |(hash)|
labels.each do |label|
  
end
