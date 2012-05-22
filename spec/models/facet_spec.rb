describe Facet do
  
  before :each do
    # create 10 cables
    4.times do
      FactoryGirl.create(:cable)
      FactoryGirl.create(:cable2)
    end
    FactoryGirl.create(:cable, type: "multi") 
    FactoryGirl.create(:cable2, type: "multi")
  end
  
  describe "structure" do
    
    it "should have an array of objects" do
      actual = FacetProc.calculate(Cable.all)
      actual.each do |v|
        v.class.should eq(Facet)
      end      
    end
    
    it "should include column names from model and relevance" do
      actual = FacetProc.calculate(Cable.all) # FIXME should pass Cable.all, so it can be get facets from nested elements
      actual.each do |v|
        v.should be_respond_to "relevance"
        v.should be_respond_to "options"
        v.should be_respond_to "name"
      end
    end
    
    it "options should be an array" do
      actual = FacetProc.calculate(Cable.all)
      actual.each do |v|
        v.options.class.should eq(Array)
      end      
    end
  end
  
 end