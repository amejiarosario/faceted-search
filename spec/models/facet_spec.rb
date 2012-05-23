describe Facet do
  
  before :each do
    # create 10 cables
    FactoryGirl.create(:cable, conductor: "1", number_pairs: "2", jacket: "METAL", number_pairs: "")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-1", insulation: "4", stranding: "19/30")
    FactoryGirl.create(:cable, conductor: "2", number_pairs: "2", insulation: "4", number_pairs: "", kevlar_core: " ")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-2", jacket: "METAL", color: "Orange")
    FactoryGirl.create(:cable, insulation: "1", jacket: "PLASTIC", diameter: "", kevlar_core: "No", pitch: "0.03")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-3", insulation: "2", stranding: "19/30", pitch: "0.03")
    FactoryGirl.create(:cable, insulation: "1", jacket: "PLASTIC", shielding: "E/D", wire_gauge: "", pitch: "0.04")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-4", insulation: "2", pitch: "0.05")
    FactoryGirl.create(:cable, type: "multi", insulation: "3", jacket: "CRYSTAL", wire_gauge: "", pitch: "0.06", number_pairs: "") # item_number: "10012-0703-9" 
    FactoryGirl.create(:cable2, type: "multi", level: 1, insulation: "3", jacket: "CRYSTAL", kevlar_core: "", pitch: "0.07") # item_number: "10012-0703-9"
  end
  
  describe "structure" do
    
    it "should have an array of objects" do
      actual = FacetProc.calculate(Cable.all)
      binding.pry
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
        v.options.class.should eq(Hash)
      end      
    end
  end
  
  describe "FacetProc" do
    it "should return an array of Facets with the column names" do
      actual = FacetProc.calculate(Cable.all)
      names = Cable.column_names
      actual.each.with_index do |v, i|
        v.name.should be == names[i]
      end
    end
    it "should sort the elements by relevance"
  end
  
  describe "Facet Objects" do
    
    before :each do
      @arr = FacetProc.calculate(Cable.all)
    end
    
    it "should return the right number of options(flat,coax,multi) for the column 'type'" do
      @arr.each do |facet|
        facet.options.keys.should =~ %w[flat coax multi] if facet.name == "type"
      end
    end

    it "should have options count ('coax'=>4, 'flat'=>4, 'multi'=>2)" do
      @arr.each do |facet|
        facet.options.should == {'coax' => 4, 'flat' => 4, 'multi' => 2} if facet.name == "type"
      end
    end
    
    describe "calculate relevance" do
      it "should have relevance=0 +/- 1 with 100% different values (item_number, mfg_part_number, id)" do
        @arr.each do |facet|
          facet.relevance.should be_within(1).of(0) if facet.name == "item_number" || facet.name == "mfg_part_number" || facet.name == "id"
        end
      end

      it "should have relevance=10 +/- 1 with 50% different values (part_type, pitch)" do
        @arr.each do |facet|
          facet.relevance.should be_within(1).of(10) if  facet.name == "pitch"
          facet.relevance.should be_within(1).of(10) if facet.name == "part_type" 
        end
      end

      it "should have relevance=0 +/- 1 with 0% different values (filename, level, conductor, wire_gauge)"
      
      it "should have relevance=0 with all null values (item_description)"
      it "should have relevance=8 +/-2 with 40-40-30 values (type)"
      it "should have relevance=5 +/- 2 with 50% values and other null (number_pairs)"
    end
  end
  
 end
