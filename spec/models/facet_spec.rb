describe Facet do
  
  before :each do
    # create 10 cables
    FactoryGirl.create(:cable,mfg_part_number: "E        C51116-1", conductor: "1", number_pairs: "2", jacket: "METAL", number_pairs: "")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-1", insulation: "4", stranding: "19/30")
    FactoryGirl.create(:cable,mfg_part_number: "E        C51116-2", conductor: "2", number_pairs: "2", insulation: "4", number_pairs: "", kevlar_core: " ")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-2", jacket: "METAL", color: "Orange")
    FactoryGirl.create(:cable,mfg_part_number: "E        C51116-3",  insulation: "1", jacket: "PLASTIC", diameter: "", kevlar_core: "No", pitch: "0.03")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-3", insulation: "2", stranding: "19/30", pitch: "0.03")
    FactoryGirl.create(:cable, insulation: "1", jacket: "PLASTIC", shielding: "E/D", wire_gauge: "", pitch: "0.04")
    FactoryGirl.create(:cable2, mfg_part_number: "E        C51116-4", insulation: "2", pitch: "0.05")
    FactoryGirl.create(:cable, mfg_part_number: "E        C51116-4",type: "multi", insulation: "3", jacket: "CRYSTAL", wire_gauge: "", pitch: "0.06", number_pairs: "") # item_number: "10012-0703-9" 
    FactoryGirl.create(:cable2, type: "multi", level: 1, insulation: "3", jacket: "CRYSTAL", kevlar_core: "", pitch: "0.07") # item_number: "10012-0703-9"
    
    @arr = FacetProc.calculate(Cable.all)
    @tolerance = 0.1
  end
 
  describe "structure" do
    
    it "should have an array of objects" do
      @arr.each do |facet|
        facet.class.should be Facet
      end
    end
    
    it "should include column names from model and relevance" do
      @arr.each do |facet|
        facet.should be_respond_to "relevance"
        facet.should be_respond_to "options"
        facet.should be_respond_to "name"
      end
    end
   
    it "options should be an array and relevance an Float"  do
      @arr.each do |facet|
        facet.options.class.should be Hash
        facet.relevance.class.should be Float
        facet.name.class.should be String
      end      
    end
  end
  
  describe "FacetProc" do
    it "should return an array of Facets with the column names" do
      actual = FacetProc.calculate(Cable.all)
      names = Cable.column_names
      actual.map(&:name).should =~ names
    end
    
    it "should sort the elements by relevance (most relevant first)" do
      prev_rel = nil
      @arr.each do |facet|
        facet.relevance.should be <= prev_rel if prev_rel
        prev_rel = facet.relevance
      end
    end
  end
  
  describe "Facet Objects" do
   
    it "should return the right number of options(flat,coax,multi) for the column 'type'" do
      @arr.each do |facet|
        facet.options.keys.should =~ ["flat", "coax", "multi", :total] if facet.name == "type"
      end
    end

    it "should have options count ('coax'=>4, 'flat'=>4, 'multi'=>2)" do
      @arr.each do |facet|
        facet.options.should == {'coax' => 4, 'flat' => 4, 'multi' => 2, :total=>10} if facet.name == "type"
      end
    end
    
    it "should be like this" do
      @arr.each do |facet|
        facet.class.should be Facet
        facet.name.class.should be String
        facet.name.should_not be_nil
        facet.name.should_not be_blank
        
        @tolerance.class.should be Float
        @tolerance.should be == 0.1
      end
    end
    
    describe "calculate relevance for:" do
      
      it "all null (item_description)" do
        @arr.each do |facet|
          facet.relevance.class.should be Float
          facet.relevance.should be_within(@tolerance).of(0) if  facet.name == "item_description"
        end
      end
      
      it "all equals (filename)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0) if  facet.name == "filename"
        end        
      end
      
      it "all different (id)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.03) if  facet.name == "id"
        end
      end
      
      it "all null but one (shielding)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0) if  facet.name == "shielding"
        end
      end
      
      it "all equal but one (level)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.03) if  facet.name == "level"
        end
      end
      
      it "2 diff no nulls (part_type)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(1) if  facet.name == "part_type"
        end
      end
      
      it "3 diff no nulls (type)" do # TODO test this with null values
        @arr.each do |facet|
          if  facet.name == "type"
            facet.relevance.should be_within(@tolerance).of(0.85)
          end 
        end
      end
      
      it "4 diff no nulls (jacket)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.14) if  facet.name == "jacket"
        end
      end
      
      it "5 diff no nulls (insulation)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.14) if  facet.name == "insulation"
        end
      end
      
      it "6 diff no nulls (mfg_part_number)", current: true do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.14) if  facet.name == "mfg_part_number"
        end
      end
      
      it "7 diff no nulls (pitch)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.03) if  facet.name == "pitch"
        end
      end
      
      it "8 diff no nulls (conductor)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.03) if  facet.name == "conductor"
        end
      end
      
      it "9 diff no nulls (number_pairs)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.01) if  facet.name == "number_pairs"
        end
      end
      
      it "3 equals other nulls (wire_gauge)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.13) if  facet.name == "wire_gauge"
        end
      end
      
      it "4 equals other nulls (diameter)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.34) if  facet.name == "diameter"
        end
      end
      
      it "5 equals other nulls (putup)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.53) if  facet.name == "putup"
        end
      end
      
      it "6 equals other nulls (color)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.51) if  facet.name == "color"
        end
      end
      
      it "7 equals other nulls (stranding)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.31) if  facet.name == "stranding"
        end
      end
      
      it "8 equals other nulls (kevlar_core)" do
        @arr.each do |facet|
          facet.relevance.should be_within(@tolerance).of(0.12) if  facet.name == "kevlar_core"
        end
      end
    end

    describe "facet with multiple options and also with nulls"
    
    #http://0.0.0.0:4000/cables?insulation=mil-w-22759%2F18+mil-w-22759%2F32&kevlar_core=No&shielding=B
    it "case when all are different, need a boost?"
    
    # FIXME
    it "should display color options!"
    #http://cable-configurator.adrianmejia.com/cables?kevlar_core=No&putup=1000&wire_gauge=22
    
    it "should detect colors with slash like White/Black/Green"
    # White/Black/Green
    
  end
  
 end
