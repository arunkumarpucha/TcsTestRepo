require 'yaml'
#shell 1 code
apple_obj = {name: "new_apple",origin: "Shimla"}

f = File.open('apple.yml','w')

YAML.dump(apple_obj,f)

f.close
 

#shell 2 code
puts "next file"

existing_apple_obj = YAML.load_file('apple.yml')

copied_apple_obj = {}

copied_apple_obj.merge!(existing_apple_obj)
puts copied_apple_obj.inspect
