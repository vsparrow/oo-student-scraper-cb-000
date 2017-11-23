class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []
  #*****************************************************************************************************************************************
  # take in an argument of a hash and use metaprogramming to assign the newly created student attributes and values
  #  in accordance with the key/value pairs of the hash
  # Use the #send method to acheive this. This method should also add the newly created student to the Student class' @@all array of all students. 
  # You'll need to create this class variable and set it equal to an empty array at the top of your class.
  #  Push self into the array at the end of the #initialize method.
  def initialize(student_hash)
    # @name=student_hash[:name]                             #works
    # @location=  student_hash[:location]  
    # @twitter = student_hash[:twitter] 
    # @linkedin =  student_hash[:linkedin]  
    # @github =  student_hash[:github]  
    # @blog =  student_hash[:blog]  
    # @profile_quote =  student_hash[:profile_quote]  
    # @bio =  student_hash[:bio]  
    # @profile_url=  student_hash[:profile_url]    
    
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value) #ex: converts :name,somename to name= value calling the attr_accessor method created for name
    end #each 
    @@all << self
    
  end #initialize
  #*****************************************************************************************************************************************
  # This class method should take in an array of hashes.
  # iterate over the array of hashes and create a new individual student using each hash.
  # In fact, we will call Student.create_from_collection with the return value of the Scraper.scrape_index_page method as the argument. 
  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)    
    end #each
  end #create_from_collection
  #*****************************************************************************************************************************************
  # This instance method should take in a hash whose key/value pairs describe additional attributes of an individual student.
  #    In fact, we will be calling student.add_student_attributes with the return value of the Scraper.scrape_profile_page method as the argument.
  # The #add_student_attributes method should iterate over the given hash and use metaprogramming to dynamically assign the student attributes 
  #   and values in accordance with the key/value pairs of the hash. Use the #send method to achieve this.
  # Important: The return value of this method should be the student itself. Use the self keyword.  
  def add_student_attributes(attributes_hash)
    # puts "*******************#{attributes_hash}"
    attributes_hash.each do |attribute, value|
      self.send("#{attribute}=", value) #ex: converts :name,somename to name= value calling the attr_accessor method created for name
    end #each 
  end #add_student_attributes
  #*****************************************************************************************************************************************
  def self.all
    @@all
  end #all
end

# shouldn't call on the Scraper class in any of its methods or take in the Scraper class itself as an argument. 
# Why is this? We want our program to be as flexible as possible. We