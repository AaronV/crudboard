
class Crudboard
  
  def awesome?
    true
  end
  
  def screencasts
    ['RESTful Rails', 'Capistrano Concepts', 'TextMate for Rails']
  end
  
end

class Book; end

describe Crudboard do
  
  before do
    @crudboard = Crudboard.new
  end
  
  it "should be awesome" do
    @crudboard.should be_awesome
  end
  
  it do
    @crudboard.should be_awesome
  end
  
  it do
    @crudboard.should_not be_an_instance_of(Book)
  end
  
  it do
    @crudboard.should have(3).screencasts
  end
  
end